import 'dart:collection';
import 'dart:io';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as path;

part 'home_data.g.dart';

/// Data of the home screen.
@CopyWith()
class HomeData with Equatable {
  /// Source directory scanned to find comics.
  final Directory? source;

  /// Destination to store compressed comics.
  final Directory destination;

  /// Image compression settings to use.
  final ImageSettings imageSettings;

  /// Image compression settings to use.
  final MiscSettings miscSettings;

  /// Progress of compression.
  final Progress? progress;

  /// Progress of compression.
  final PipelineState pipelineState;

  const new({
    required this.source,
    required this.destination,
    required this.imageSettings,
    required this.miscSettings,
    required this.progress,
    required this.pipelineState,
  });
  new blank()
    : source = null,
      destination = Directory(path.context.current),
      imageSettings = .blank(),
      miscSettings = .blank(),
      progress = null,
      pipelineState = .blank();

  @override
  List<Object?> get props => [
    source,
    destination,
    imageSettings,
    miscSettings,
    progress,
    pipelineState,
  ];
}

/// State of the compression pipeline manager.
@CopyWith()
class PipelineState with Equatable {
  /// Wheter compression is started.
  final bool started;

  /// Wheter compression is started but paused.
  final bool paused;

  /// Signals the pipeline manager
  final bool windDown;

  const new({
    required this.started,
    required this.paused,
    required this.windDown,
  });

  const new blank() : started = false, paused = false, windDown = false;
  @override
  List<Object?> get props => [started, paused, windDown];
}

enum ImageCodec { jxl, webp, webpLossless, cjpeg }

/// Settings to use for image compression.
sealed class ImageSettings with Equatable {
  /// Number of settings in section. To determine its height.
  int get settingCount;

  /// Codec to use.
  final ImageCodec codec;
  const new({required this.codec});
  factory blank() => JxlImageSettings.blank();
  factory codec(ImageCodec codec) => switch (codec) {
    .jxl => JxlImageSettings.blank(),
    .webp => WebpImageSettings.blank(),
    .webpLossless => WebpLosslessImageSettings.blank(),
    .cjpeg => CJpegImageSettings.blank(),
  };
  @override
  List<Object?> get props => [codec];
}

/// Jxl-specific image settings.
@CopyWith()
final class JxlImageSettings extends ImageSettings {
  @override
  int get settingCount => 3;

  /// Inverse of quality. 0 = lossless, 1 = indistinguishable, higher = worse.
  final double distance;

  /// Effort to compress better. 1-9.
  final int effort;
  const new({required this.distance, required this.effort})
    : super(codec: .jxl);
  const new blank() : distance = 0, effort = 9, super(codec: .jxl);

  @override
  List<Object?> get props => [...super.props, distance, effort];
}

enum WebpPreset {
  none("default"),
  photo("photo"),
  picture("picture"),
  drawing("drawing"),
  icon("icon"),
  text("text");

  const new(this.name);
  final String name;
}

/// Lossy webp specific image settings.
@CopyWith()
final class WebpImageSettings extends ImageSettings {
  @override
  int get settingCount => 4;

  /// Preset setting.
  final WebpPreset preset;

  /// Quality of image. 0-100.
  final int quality;

  /// Effort to compress better. 0-6.
  final int effort;
  const new({required this.preset, required this.quality, required this.effort})
    : super(codec: .webp);
  const new blank()
    : preset = .drawing,
      quality = 75,
      effort = 6,
      super(codec: .webp);

  @override
  List<Object?> get props => [...super.props, preset, quality, effort];
}

/// Lossless webp specific image settings.
@CopyWith()
final class WebpLosslessImageSettings extends ImageSettings {
  @override
  int get settingCount => 3;

  /// Preset setting.
  final WebpPreset preset;

  /// Effort to compress better. 0-9.
  final int effort;
  const new({required this.preset, required this.effort})
    : super(codec: .webpLossless);
  const new blank()
    : preset = .drawing,
      effort = 9,
      super(codec: .webpLossless);

  @override
  List<Object?> get props => [...super.props, preset, effort];
}

/// Jpeg specific image settings.
@CopyWith()
final class CJpegImageSettings extends ImageSettings {
  @override
  int get settingCount => 2;

  /// Quality of image. 0-100.
  final int quality;

  const new({required this.quality}) : super(codec: .cjpeg);
  const new blank() : quality = 75, super(codec: .cjpeg);

  @override
  List<Object?> get props => [...super.props, quality];
}

/// Misc settings to use during compression.
@CopyWith()
class MiscSettings with Equatable {
  /// Settings for regex filtering operations.
  final FilterSettings filterSettings;

  /// Wheter to convert alphanumerically sorted image paths
  /// to numeric names at archive root.
  final bool normalizeFlatten;

  /// Number of job runners.
  final int threadCount;

  /// Wheter to copy non-comic files to destination.
  final bool copyNonComicFiles;

  /// Level (effort) for zip.
  final int zipEffort;

  const new({
    required this.filterSettings,
    required this.normalizeFlatten,
    required this.threadCount,
    required this.copyNonComicFiles,
    required this.zipEffort,
  });

  new blank()
    : filterSettings = .blank(),
      normalizeFlatten = false,
      threadCount = Platform.numberOfProcessors,
      copyNonComicFiles = true,
      zipEffort = 0;
  @override
  List<Object?> get props => [
    normalizeFlatten,
    threadCount,
    filterSettings,
    copyNonComicFiles,
    zipEffort,
  ];
}

/// Filters to apply to files in the archive.
/// The regexes are matched against each individual component
/// of the file path in the archive, not the entire path at once.
@CopyWith()
class FilterSettings with Equatable {
  /// Files to exclude from the archive.
  final List<RegExp> excludedNames;

  /// Files to not reencode.
  /// Files not included here and fail to reencode will not be in the final archive.
  final List<RegExp> untouchedNames;

  const new({required this.excludedNames, required this.untouchedNames});

  new blank()
    : excludedNames = [RegExp("^\\.")],
      untouchedNames = [RegExp("^ComicInfo\\.xml\$")];
  @override
  List<Object?> get props => [excludedNames, untouchedNames];
}

/// Information about the compression progress of the selected folder.
@CopyWith()
class Progress with Equatable {
  /// Comic files found.
  final List<QueuedFile> comicFiles;

  /// Non-comic files found.
  final List<File> otherFiles;

  /// Size of comic files in bytes.
  final int comicFilesSize;

  /// Size of non-comic files in bytes.
  final int otherFilesSize;

  /// Indecies of comics in progress.
  final List<int> inProgressIndecies;

  /// Number of comics finished.
  final int finishedCount;

  /// Size of the finished comics.
  final int finishedSize;

  /// Effective time when the compression started.
  /// If compression is paused then resumed this time is shifted forwards by
  /// the paused period.
  final DateTime? startTime;

  /// Time when the compression was paused.
  final DateTime? pauseTime;
  const new({
    required this.comicFiles,
    required this.otherFiles,
    required this.comicFilesSize,
    required this.otherFilesSize,
    required this.inProgressIndecies,
    required this.finishedCount,
    required this.finishedSize,
    required this.startTime,
    required this.pauseTime,
  });
  new blank({
    required Directory source,
    required List<File> comicFiles,
    required this.otherFiles,
    required this.comicFilesSize,
    required this.otherFilesSize,
  }) : comicFiles = comicFiles
           .map((file) => QueuedFile.blank(source: source, file: file))
           .toList(),
       inProgressIndecies = [],
       finishedCount = 0,
       finishedSize = 0,
       startTime = null,
       pauseTime = null;

  int get startedCount => inProgressIndecies.length + finishedCount;
  int get notStartedCount => comicFiles.length - startedCount;
  Duration? get ongoingTime =>
      startTime == null ? null : DateTime.now().difference(startTime!);
  double? get filesPerSecond =>
      ongoingTime == null ? null : finishedCount / ongoingTime!.inSeconds;
  double? get bytesPerSecond =>
      ongoingTime == null ? null : finishedCount / ongoingTime!.inSeconds;
  double? get remainingSecondsFiles => filesPerSecond == null
      ? null
      : (comicFiles.length - finishedCount) / filesPerSecond!;
  double? get remainingSecondsBytes => bytesPerSecond == null
      ? null
      : (comicFiles.length - finishedCount) / bytesPerSecond!;

  @override
  List<Object?> get props => [
    comicFiles,
    otherFiles,
    comicFilesSize,
    inProgressIndecies,
    finishedCount,
    finishedSize,
    startTime,
    pauseTime,
  ];
}

enum PipelineStage {
  queued,
  copy,
  unpack,
  filter,
  compress,
  repack,
  move,
  finished,
}

/// Information about a comic file in queue.
@CopyWith()
class QueuedFile with Equatable {
  /// Path of the file relative to the source folder.
  final String relativePath;

  /// Stage in the pipeline.
  final PipelineStage stage;

  /// Ratio of images compressed to image count when in compress stage.
  final double compressionStageRatio;

  const new({
    required this.relativePath,
    required this.stage,
    required this.compressionStageRatio,
  });
  new blank({required Directory source, required File file})
    : relativePath = path.relative(file.path, from: source.path),
      stage = .queued,
      compressionStageRatio = 0;

  @override
  List<Object?> get props => [relativePath, stage, compressionStageRatio];
}
