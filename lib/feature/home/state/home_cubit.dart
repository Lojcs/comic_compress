import 'dart:collection';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive_io.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart' as path;
import 'package:unrar/unrar.dart';
import 'package:window_manager/window_manager.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/function_extension.dart';
import '../../../core/extensions/list_get_copy_with_extension.dart';
import '../../../core/state/mubit.dart';
import '../../../core/util/isolater.dart';
import '../widget/home_screen.dart';
import 'compression/compression_pipeline.dart';
import 'home_data.dart';
import 'compression/pipeline_manager.dart';

class HomeCubit extends Mubit<HomeData> {
  new() : super(HomeData.blank());

  late final PipelineManager _manager = PipelineManager(cubit: this);

  bool isComic(File file) => switch (path.extension(file.path)) {
    ".cbz" || ".cbr" => true,
    _ => false,
  };

  Future<void> setCodec(ImageCodec codec) async {
    final settings = ImageSettings.codec(codec);
    await windowManager.setSize(
      HomeScreen.size(settings, state.source != null),
    );
    emit(state.copyWith(imageSettings: settings));
  }

  /// Sets the source directory and scans it.
  Future<void> setSource(Directory? source) async {
    if (source != null && await source.exists()) {
      final files = await source.list(recursive: true).toList();
      final comicFiles = <File>[];
      final otherFiles = <File>[];
      for (final file in files) {
        if (file is File) {
          if (isComic(file)) {
            comicFiles.add(file);
          } else {
            otherFiles.add(file);
          }
        }
      }
      final comicFileSizes = await Future.wait(
        comicFiles.map((file) async => (await file.stat()).size),
      );
      final otherFileSizes = await Future.wait(
        otherFiles.map((file) async => (await file.stat()).size),
      );
      final comicFilesSize = comicFileSizes.fold(0, (a, b) => a + b);
      final otherFilesSize = otherFileSizes.fold(0, (a, b) => a + b);
      await windowManager.setSize(HomeScreen.size(state.imageSettings, true));
      emit(
        state.copyWith(
          source: source,
          progress: Progress.blank(
            source: source,
            comicFiles: comicFiles,
            otherFiles: otherFiles,
            comicFilesSize: comicFilesSize,
            otherFilesSize: otherFilesSize,
          ),
        ),
      );
    }
  }

  /// Starts the compression.
  void startCompression() {
    _manager.start();
    emit(
      state.copyWith(
        pipelineState: state.pipelineState.copyWith.started(true),
        progress: state.progress!.copyWith.startTime(DateTime.now()),
      ),
    );
  }

  /// Pauses the compression (gradually).
  void pauseCompression() {
    emit(
      state.copyWith(
        pipelineState: state.pipelineState.copyWith.paused(true),
        progress: state.progress!.copyWith.pauseTime(DateTime.now()),
      ),
    );
  }

  /// Resumes the started compression.
  void resumeCompression() {
    final pausePeriod = DateTime.now().difference(state.progress!.pauseTime!);
    emit(
      state.copyWith(
        pipelineState: state.pipelineState.copyWith.paused(false),
        progress: state.progress!.copyWith.startTime(
          state.progress!.startTime!.add(pausePeriod),
        ),
      ),
    );
  }

  /// Stops the compression.
  void stopCompression() {
    _manager.stop();
    emit(
      state.copyWith(
        pipelineState: PipelineState.blank(),
        progress: state.progress!.copyWith.pauseTime(DateTime.now()),
      ),
    );
  }

  /// Gets the next queued file not yet in progress.
  int? getNextIndex() {
    if (state.progress!.startedCount == state.progress!.comicFiles.length) {
      return null;
    }
    final index = state.progress!.startedCount;
    emit(
      state.copyWith.progress.at(state.progress!.copyWith.inProgressIndecies)([
        ...state.progress!.inProgressIndecies,
        index,
      ]),
    );
    return index;
  }

  /// Changes the state of a queued file.
  Future<void> changeStage(
    int index,
    PipelineStage stage, [
    double? compressionStageRatio,
  ]) async {
    if (stage == .compress) {
      emit(
        state.copyWith.progress
            .at(state.progress!.copyWith.comicFiles)
            .at(state.progress!.comicFiles.toList().getCopyWith(index))
            .at(
              state.progress!.comicFiles[index].copyWith.compressionStageRatio,
            )(compressionStageRatio!),
      );
    }
    if (stage == .finished) {
      final finishedFilePath = path.join(
        state.destination.path,
        state.progress!.comicFiles[index].relativePath,
      );
      await Future.pause(Duration(milliseconds: 500));
      final stat = await File(finishedFilePath).stat(); // How's this wrong??!!
      emit(
        state.copyWith.progress(
          state.progress!.copyWith(
            inProgressIndecies: [...state.progress!.inProgressIndecies]
              ..remove(index),
            finishedCount: state.progress!.finishedCount + 1,
            finishedSize: state.progress!.finishedSize + stat.size,
          ),
        ),
      );
    }
    emit(
      state.copyWith.progress
          .at(state.progress!.copyWith.comicFiles)
          .at(state.progress!.comicFiles.toList().getCopyWith(index))
          .at(state.progress!.comicFiles[index].copyWith.stage)(stage),
    );
  }
}
