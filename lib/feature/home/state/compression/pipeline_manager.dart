import 'dart:collection';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:unrar/unrar.dart';
import 'package:window_manager/window_manager.dart';

import '../../../../core/extensions/function_extension.dart';
import '../../../../core/util/isolated.dart';
import '../../../../core/util/isolater.dart';
import 'compression_pipeline.dart';
import '../home_cubit.dart';
import '../home_data.dart';

typedef PipelineJob = Future<void> Function(Isolated isolate);

class _WindowCloseListener extends WindowListener {
  final VoidCallback onClose;

  new(this.onClose);

  @override
  void onWindowClose() => onClose();
}

/// Manages compression pipelines and runners.
class PipelineManager {
  final HomeCubit cubit;
  new({required this.cubit}) {
    WindowManager.instance.addListener(_WindowCloseListener(stop));
  }

  late Directory tempDir;

  PipelineState get state => cubit.state.pipelineState;

  final ListQueue<PipelineJob> _jobQueue = ListQueue();
  final List<Isolated> _isolates = [];

  /// Adds a job to the queue.
  /// If null is added the runners start winding down.
  void addJob(PipelineJob? job) {
    if (job == null) {
      cubit.mutate
          .by((a) => a.copyWith.pipelineState)
          .at(state.copyWith.windDown)(true);
    } else {
      _jobQueue.add(job);
    }
  }

  /// Runs a job slot.
  Future<void> runJobSlot() async {
    try {
      final isolate = await Isolated.spawn();
      _isolates.add(isolate);
      while (state.started) {
        if (_jobQueue.isEmpty || state.paused) {
          await Future.pause(Duration(seconds: 1));
          if (state.windDown) break;
          continue;
        }
        final job = _jobQueue.removeFirst();
        await job(isolate);
      }
      isolate.kill();
      _isolates.remove(isolate);
      if (_isolates.isEmpty) stop();
    } on IsolatedKilledException {
      // Do nothing
    }
  }

  /// Starts the compression pipelines.
  /// Expects the manager to be in stopped state.
  Future<void> start() async {
    tempDir = await Directory.systemTemp.createTemp("comic_compress");
    if (cubit.state.miscSettings.copyNonComicFiles) await copyOtherFiles();
    for (var i = 0; i < cubit.state.miscSettings.threadCount; i++) {
      CompressionPipeline.start(cubit, tempDir, addJob);
    }
    for (var i = 0; i < cubit.state.miscSettings.threadCount; i++) {
      runJobSlot();
    }
  }

  /// Force stops the pipelines.
  Future<void> stop() async {
    for (final isolate in _isolates) {
      isolate.kill();
    }
    _isolates.clear();
    _jobQueue.clear();
    await tempDir.delete(recursive: true);
  }

  /// Copies non-comic files to destination.
  Future<void> copyOtherFiles() async {
    for (final file in cubit.state.progress!.otherFiles) {
      final relativePath = path.relative(
        file.path,
        from: cubit.state.source!.path,
      );
      final destinationPath = path.join(
        cubit.state.destination.path,
        relativePath,
      );
      await File(destinationPath).create(recursive: true);
      await file.copy(destinationPath);
    }
  }
}
