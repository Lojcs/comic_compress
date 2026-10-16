import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';

typedef IsolateSpawnInput = ({RootIsolateToken token, SendPort sendPort});

typedef _WorkPackage<R, I> = ({
  int id,
  Future<R> Function(I input) computation,
  I input,
});

typedef _WorkResult<R> = ({int id, R result});

class IsolatedKilledException implements Exception {
  @override
  String toString() => "The Isolated was killed while processing this.";
}

/// Similar to [Isolater], but uses a persistent isolate
/// that can be reused or killed.
/// Usage:
/// ```dart
/// final isolate = await Isolated.spawn();
/// final result = await isolate.run(func, arg);
/// final result2 = await isolate.run(func2, arg2);
/// await isolate.kill()
/// ```
///
class Isolated {
  final Isolate _isolate;
  final ReceivePort _receivePort;
  late final SendPort _sendPort;
  new _({required this._isolate, required this._receivePort}) {
    _receivePort.listen(_messageHandler);
  }

  final Completer<Isolated> _ready = Completer();

  static Future<Isolated> spawn() async {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      (IsolateSpawnInput input) => _spawner(input),
      (
        token: ServicesBinding.rootIsolateToken!,
        sendPort: receivePort.sendPort,
      ),
    );
    final isolated = Isolated._(isolate: isolate, receivePort: receivePort);
    return isolated._ready.future;
  }

  int _nextJobId = 0;
  final Map<int, Completer<dynamic>> _completers = {};
  int? subprocessPid;

  Future<R> run<R, I>(Future<R> Function(I input) computation, I input) {
    final id = _nextJobId;
    _nextJobId++;
    final completer = Completer<R>();
    _completers[id] = completer;
    final _WorkPackage<R, I> workPackage = (
      id: id,
      computation: computation,
      input: input,
    );
    _sendPort.send(workPackage);
    return completer.future;
  }

  void kill() async {
    _sendPort.send(0);
  }

  Future<void> _messageHandler(dynamic message) async {
    if (message is SendPort) {
      _sendPort = message;
      _ready.complete(this);
    } else if (message is _WorkResult) {
      _completers[message.id]!.complete(message.result);
    } else if (message == 0) {
      _receivePort.close();
      _isolate.kill();
      for (final completer in _completers.values) {
        if (!completer.isCompleted) {
          completer.completeError(IsolatedKilledException());
        }
      }
    }
  }

  static Process? subprocess;
  @pragma('vm:entry-point')
  static void _spawner<S>(IsolateSpawnInput args) {
    BackgroundIsolateBinaryMessenger.ensureInitialized(args.token);
    final receivePort = ReceivePort();
    args.sendPort.send(receivePort.sendPort);

    receivePort.listen((message) async {
      if (message == 0) {
        subprocess?.kill();
        args.sendPort.send(0);
      } else {
        final result = await message.computation(message.input);
        final _WorkResult workResult = (id: message.id, result: result);
        args.sendPort.send(workResult);
      }
    });
  }
}
