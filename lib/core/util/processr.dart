import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'isolated.dart';

/// Exfiltrates the subprocess so it can be killed alongside the isolate.
class Processr {
  static Future<ProcessResult> run(
    String executable,
    List<String> arguments, {
    String? workingDirectory,
    Map<String, String>? environment,
    bool includeParentEnvironment = true,
    bool runInShell = false,
    Encoding? stdoutEncoding = systemEncoding,
    Encoding? stderrEncoding = systemEncoding,
  }) async {
    final process = await Process.start(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      environment: environment,
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
    );
    Isolated.subprocess = process;
    return ProcessResult(
      process.pid,
      await process.exitCode,
      stdoutEncoding?.decode(await process.stdout.expand((e) => e).toList()) ??
          Uint8List.fromList(await process.stdout.expand((e) => e).toList()),
      stderrEncoding?.decode(await process.stderr.expand((e) => e).toList()) ??
          Uint8List.fromList(await process.stderr.expand((e) => e).toList()),
    );
  }
}
