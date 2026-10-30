import 'dart:isolate';
import 'dart:ui';

import '../home_data.dart';

enum WorkerCommand { init, work, stop }

class WorkerMessage {
  final WorkerCommand command;
  final PipelineStage stage;
  final dynamic input;
  const WorkerMessage({
    required this.command,
    required this.stage,
    required this.input,
  });
}

void isolateMessageHandler(WorkerMessage message, SendPort sendPort) {}

void _isolateMessageHandler(
  WorkerMessage message,
  SendPort sendPort,
  VoidCallback quit,
) {
  switch (message) {
    case WorkerMessage(command: .stop):
      break;
    default:
  }
}

class _IsolateWorker {
  final SendPort sendPort;
  final ReceivePort receivePort;

  new({required this.sendPort, required this.receivePort});

  static void startWorker(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _IsolateWorker(sendPort: sendPort, receivePort: receivePort);
  }
}
