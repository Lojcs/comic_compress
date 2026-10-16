import 'dart:isolate';

import 'package:flutter/services.dart';

/// Launders [Isolate.run] so it doesn't capture unnecessary variables.
/// Also ensures [BackgroundIsolateBinaryMessenger] is initialized.
/// Instead of:
/// ```dart
/// final result = await Isolate.run(() => func(arg));
/// ```
/// Use this:
/// ```dart
/// final result = await Isolater(func).run(arg);
/// ```
///
class Isolater<R, I> {
  Future<R> Function(I input) computation;
  final rootIsolateToken = ServicesBinding.rootIsolateToken!;
  new(this.computation);

  Future<R> run(I input) =>
      Isolate.run(() => _runner(rootIsolateToken, computation, input));
  @pragma('vm:entry-point')
  static Future<R> _runner<R, I>(
    RootIsolateToken token,
    Future<R> Function(I input) computation,
    I input,
  ) {
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);
    return computation(input);
  }
}
