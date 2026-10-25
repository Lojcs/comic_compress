// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeDataCWProxy {
  HomeData source(Directory? source);

  HomeData destination(Directory destination);

  HomeData imageSettings(ImageSettings imageSettings);

  HomeData miscSettings(MiscSettings miscSettings);

  HomeData progress(Progress progress);

  HomeData pipelineState(PipelineState pipelineState);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HomeData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeData(...).copyWith(id: 12, name: "My name")
  /// ```
  HomeData call({
    Directory? source,
    Directory destination,
    ImageSettings imageSettings,
    MiscSettings miscSettings,
    Progress progress,
    PipelineState pipelineState,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfHomeData.copyWith(...)` or call `instanceOfHomeData.copyWith.fieldName(value)` for a single field.
class _$HomeDataCWProxyImpl implements _$HomeDataCWProxy {
  const _$HomeDataCWProxyImpl(this._value);

  final HomeData _value;

  @override
  HomeData source(Directory? source) => call(source: source);

  @override
  HomeData destination(Directory destination) => call(destination: destination);

  @override
  HomeData imageSettings(ImageSettings imageSettings) =>
      call(imageSettings: imageSettings);

  @override
  HomeData miscSettings(MiscSettings miscSettings) =>
      call(miscSettings: miscSettings);

  @override
  HomeData progress(Progress progress) => call(progress: progress);

  @override
  HomeData pipelineState(PipelineState pipelineState) =>
      call(pipelineState: pipelineState);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `HomeData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// HomeData(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  HomeData call({
    Object? source = const $CopyWithPlaceholder(),
    Object? destination = const $CopyWithPlaceholder(),
    Object? imageSettings = const $CopyWithPlaceholder(),
    Object? miscSettings = const $CopyWithPlaceholder(),
    Object? progress = const $CopyWithPlaceholder(),
    Object? pipelineState = const $CopyWithPlaceholder(),
  }) {
    return HomeData(
      source: source == const $CopyWithPlaceholder()
          ? _value.source
          // ignore: cast_nullable_to_non_nullable
          : source as Directory?,
      destination:
          destination == const $CopyWithPlaceholder() || destination == null
          ? _value.destination
          // ignore: cast_nullable_to_non_nullable
          : destination as Directory,
      imageSettings:
          imageSettings == const $CopyWithPlaceholder() || imageSettings == null
          ? _value.imageSettings
          // ignore: cast_nullable_to_non_nullable
          : imageSettings as ImageSettings,
      miscSettings:
          miscSettings == const $CopyWithPlaceholder() || miscSettings == null
          ? _value.miscSettings
          // ignore: cast_nullable_to_non_nullable
          : miscSettings as MiscSettings,
      progress: progress == const $CopyWithPlaceholder() || progress == null
          ? _value.progress
          // ignore: cast_nullable_to_non_nullable
          : progress as Progress,
      pipelineState:
          pipelineState == const $CopyWithPlaceholder() || pipelineState == null
          ? _value.pipelineState
          // ignore: cast_nullable_to_non_nullable
          : pipelineState as PipelineState,
    );
  }
}

extension $HomeDataCopyWith on HomeData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfHomeData.copyWith(...)` or `instanceOfHomeData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeDataCWProxy get copyWith => _$HomeDataCWProxyImpl(this);
}

abstract class _$PipelineStateCWProxy {
  PipelineState started(bool started);

  PipelineState paused(bool paused);

  PipelineState windDown(bool windDown);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PipelineState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PipelineState(...).copyWith(id: 12, name: "My name")
  /// ```
  PipelineState call({bool started, bool paused, bool windDown});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPipelineState.copyWith(...)` or call `instanceOfPipelineState.copyWith.fieldName(value)` for a single field.
class _$PipelineStateCWProxyImpl implements _$PipelineStateCWProxy {
  const _$PipelineStateCWProxyImpl(this._value);

  final PipelineState _value;

  @override
  PipelineState started(bool started) => call(started: started);

  @override
  PipelineState paused(bool paused) => call(paused: paused);

  @override
  PipelineState windDown(bool windDown) => call(windDown: windDown);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `PipelineState(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PipelineState(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  PipelineState call({
    Object? started = const $CopyWithPlaceholder(),
    Object? paused = const $CopyWithPlaceholder(),
    Object? windDown = const $CopyWithPlaceholder(),
  }) {
    return PipelineState(
      started: started == const $CopyWithPlaceholder() || started == null
          ? _value.started
          // ignore: cast_nullable_to_non_nullable
          : started as bool,
      paused: paused == const $CopyWithPlaceholder() || paused == null
          ? _value.paused
          // ignore: cast_nullable_to_non_nullable
          : paused as bool,
      windDown: windDown == const $CopyWithPlaceholder() || windDown == null
          ? _value.windDown
          // ignore: cast_nullable_to_non_nullable
          : windDown as bool,
    );
  }
}

extension $PipelineStateCopyWith on PipelineState {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPipelineState.copyWith(...)` or `instanceOfPipelineState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PipelineStateCWProxy get copyWith => _$PipelineStateCWProxyImpl(this);
}

abstract class _$JxlImageSettingsCWProxy {
  JxlImageSettings distance(double distance);

  JxlImageSettings effort(int effort);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `JxlImageSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// JxlImageSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  JxlImageSettings call({double distance, int effort});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfJxlImageSettings.copyWith(...)` or call `instanceOfJxlImageSettings.copyWith.fieldName(value)` for a single field.
class _$JxlImageSettingsCWProxyImpl implements _$JxlImageSettingsCWProxy {
  const _$JxlImageSettingsCWProxyImpl(this._value);

  final JxlImageSettings _value;

  @override
  JxlImageSettings distance(double distance) => call(distance: distance);

  @override
  JxlImageSettings effort(int effort) => call(effort: effort);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `JxlImageSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// JxlImageSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  JxlImageSettings call({
    Object? distance = const $CopyWithPlaceholder(),
    Object? effort = const $CopyWithPlaceholder(),
  }) {
    return JxlImageSettings(
      distance: distance == const $CopyWithPlaceholder() || distance == null
          ? _value.distance
          // ignore: cast_nullable_to_non_nullable
          : distance as double,
      effort: effort == const $CopyWithPlaceholder() || effort == null
          ? _value.effort
          // ignore: cast_nullable_to_non_nullable
          : effort as int,
    );
  }
}

extension $JxlImageSettingsCopyWith on JxlImageSettings {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfJxlImageSettings.copyWith(...)` or `instanceOfJxlImageSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$JxlImageSettingsCWProxy get copyWith => _$JxlImageSettingsCWProxyImpl(this);
}

abstract class _$WebpImageSettingsCWProxy {
  WebpImageSettings preset(WebpPreset preset);

  WebpImageSettings quality(int quality);

  WebpImageSettings effort(int effort);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `WebpImageSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WebpImageSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  WebpImageSettings call({WebpPreset preset, int quality, int effort});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWebpImageSettings.copyWith(...)` or call `instanceOfWebpImageSettings.copyWith.fieldName(value)` for a single field.
class _$WebpImageSettingsCWProxyImpl implements _$WebpImageSettingsCWProxy {
  const _$WebpImageSettingsCWProxyImpl(this._value);

  final WebpImageSettings _value;

  @override
  WebpImageSettings preset(WebpPreset preset) => call(preset: preset);

  @override
  WebpImageSettings quality(int quality) => call(quality: quality);

  @override
  WebpImageSettings effort(int effort) => call(effort: effort);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `WebpImageSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WebpImageSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  WebpImageSettings call({
    Object? preset = const $CopyWithPlaceholder(),
    Object? quality = const $CopyWithPlaceholder(),
    Object? effort = const $CopyWithPlaceholder(),
  }) {
    return WebpImageSettings(
      preset: preset == const $CopyWithPlaceholder() || preset == null
          ? _value.preset
          // ignore: cast_nullable_to_non_nullable
          : preset as WebpPreset,
      quality: quality == const $CopyWithPlaceholder() || quality == null
          ? _value.quality
          // ignore: cast_nullable_to_non_nullable
          : quality as int,
      effort: effort == const $CopyWithPlaceholder() || effort == null
          ? _value.effort
          // ignore: cast_nullable_to_non_nullable
          : effort as int,
    );
  }
}

extension $WebpImageSettingsCopyWith on WebpImageSettings {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWebpImageSettings.copyWith(...)` or `instanceOfWebpImageSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WebpImageSettingsCWProxy get copyWith =>
      _$WebpImageSettingsCWProxyImpl(this);
}

abstract class _$WebpLosslessImageSettingsCWProxy {
  WebpLosslessImageSettings preset(WebpPreset preset);

  WebpLosslessImageSettings effort(int effort);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `WebpLosslessImageSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WebpLosslessImageSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  WebpLosslessImageSettings call({WebpPreset preset, int effort});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfWebpLosslessImageSettings.copyWith(...)` or call `instanceOfWebpLosslessImageSettings.copyWith.fieldName(value)` for a single field.
class _$WebpLosslessImageSettingsCWProxyImpl
    implements _$WebpLosslessImageSettingsCWProxy {
  const _$WebpLosslessImageSettingsCWProxyImpl(this._value);

  final WebpLosslessImageSettings _value;

  @override
  WebpLosslessImageSettings preset(WebpPreset preset) => call(preset: preset);

  @override
  WebpLosslessImageSettings effort(int effort) => call(effort: effort);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `WebpLosslessImageSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// WebpLosslessImageSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  WebpLosslessImageSettings call({
    Object? preset = const $CopyWithPlaceholder(),
    Object? effort = const $CopyWithPlaceholder(),
  }) {
    return WebpLosslessImageSettings(
      preset: preset == const $CopyWithPlaceholder() || preset == null
          ? _value.preset
          // ignore: cast_nullable_to_non_nullable
          : preset as WebpPreset,
      effort: effort == const $CopyWithPlaceholder() || effort == null
          ? _value.effort
          // ignore: cast_nullable_to_non_nullable
          : effort as int,
    );
  }
}

extension $WebpLosslessImageSettingsCopyWith on WebpLosslessImageSettings {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfWebpLosslessImageSettings.copyWith(...)` or `instanceOfWebpLosslessImageSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WebpLosslessImageSettingsCWProxy get copyWith =>
      _$WebpLosslessImageSettingsCWProxyImpl(this);
}

abstract class _$CJpegImageSettingsCWProxy {
  CJpegImageSettings quality(int quality);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CJpegImageSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CJpegImageSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  CJpegImageSettings call({int quality});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfCJpegImageSettings.copyWith(...)` or call `instanceOfCJpegImageSettings.copyWith.fieldName(value)` for a single field.
class _$CJpegImageSettingsCWProxyImpl implements _$CJpegImageSettingsCWProxy {
  const _$CJpegImageSettingsCWProxyImpl(this._value);

  final CJpegImageSettings _value;

  @override
  CJpegImageSettings quality(int quality) => call(quality: quality);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `CJpegImageSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// CJpegImageSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  CJpegImageSettings call({Object? quality = const $CopyWithPlaceholder()}) {
    return CJpegImageSettings(
      quality: quality == const $CopyWithPlaceholder() || quality == null
          ? _value.quality
          // ignore: cast_nullable_to_non_nullable
          : quality as int,
    );
  }
}

extension $CJpegImageSettingsCopyWith on CJpegImageSettings {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfCJpegImageSettings.copyWith(...)` or `instanceOfCJpegImageSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CJpegImageSettingsCWProxy get copyWith =>
      _$CJpegImageSettingsCWProxyImpl(this);
}

abstract class _$MiscSettingsCWProxy {
  MiscSettings filterSettings(FilterSettings filterSettings);

  MiscSettings normalizeFlatten(bool normalizeFlatten);

  MiscSettings threadCount(int threadCount);

  MiscSettings copyNonComicFiles(bool copyNonComicFiles);

  MiscSettings zipEffort(int zipEffort);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MiscSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MiscSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  MiscSettings call({
    FilterSettings filterSettings,
    bool normalizeFlatten,
    int threadCount,
    bool copyNonComicFiles,
    int zipEffort,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMiscSettings.copyWith(...)` or call `instanceOfMiscSettings.copyWith.fieldName(value)` for a single field.
class _$MiscSettingsCWProxyImpl implements _$MiscSettingsCWProxy {
  const _$MiscSettingsCWProxyImpl(this._value);

  final MiscSettings _value;

  @override
  MiscSettings filterSettings(FilterSettings filterSettings) =>
      call(filterSettings: filterSettings);

  @override
  MiscSettings normalizeFlatten(bool normalizeFlatten) =>
      call(normalizeFlatten: normalizeFlatten);

  @override
  MiscSettings threadCount(int threadCount) => call(threadCount: threadCount);

  @override
  MiscSettings copyNonComicFiles(bool copyNonComicFiles) =>
      call(copyNonComicFiles: copyNonComicFiles);

  @override
  MiscSettings zipEffort(int zipEffort) => call(zipEffort: zipEffort);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `MiscSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MiscSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  MiscSettings call({
    Object? filterSettings = const $CopyWithPlaceholder(),
    Object? normalizeFlatten = const $CopyWithPlaceholder(),
    Object? threadCount = const $CopyWithPlaceholder(),
    Object? copyNonComicFiles = const $CopyWithPlaceholder(),
    Object? zipEffort = const $CopyWithPlaceholder(),
  }) {
    return MiscSettings(
      filterSettings:
          filterSettings == const $CopyWithPlaceholder() ||
              filterSettings == null
          ? _value.filterSettings
          // ignore: cast_nullable_to_non_nullable
          : filterSettings as FilterSettings,
      normalizeFlatten:
          normalizeFlatten == const $CopyWithPlaceholder() ||
              normalizeFlatten == null
          ? _value.normalizeFlatten
          // ignore: cast_nullable_to_non_nullable
          : normalizeFlatten as bool,
      threadCount:
          threadCount == const $CopyWithPlaceholder() || threadCount == null
          ? _value.threadCount
          // ignore: cast_nullable_to_non_nullable
          : threadCount as int,
      copyNonComicFiles:
          copyNonComicFiles == const $CopyWithPlaceholder() ||
              copyNonComicFiles == null
          ? _value.copyNonComicFiles
          // ignore: cast_nullable_to_non_nullable
          : copyNonComicFiles as bool,
      zipEffort: zipEffort == const $CopyWithPlaceholder() || zipEffort == null
          ? _value.zipEffort
          // ignore: cast_nullable_to_non_nullable
          : zipEffort as int,
    );
  }
}

extension $MiscSettingsCopyWith on MiscSettings {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMiscSettings.copyWith(...)` or `instanceOfMiscSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MiscSettingsCWProxy get copyWith => _$MiscSettingsCWProxyImpl(this);
}

abstract class _$FilterSettingsCWProxy {
  FilterSettings excludedNames(List<RegExp> excludedNames);

  FilterSettings untouchedNames(List<RegExp> untouchedNames);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `FilterSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FilterSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  FilterSettings call({
    List<RegExp> excludedNames,
    List<RegExp> untouchedNames,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFilterSettings.copyWith(...)` or call `instanceOfFilterSettings.copyWith.fieldName(value)` for a single field.
class _$FilterSettingsCWProxyImpl implements _$FilterSettingsCWProxy {
  const _$FilterSettingsCWProxyImpl(this._value);

  final FilterSettings _value;

  @override
  FilterSettings excludedNames(List<RegExp> excludedNames) =>
      call(excludedNames: excludedNames);

  @override
  FilterSettings untouchedNames(List<RegExp> untouchedNames) =>
      call(untouchedNames: untouchedNames);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `FilterSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FilterSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  FilterSettings call({
    Object? excludedNames = const $CopyWithPlaceholder(),
    Object? untouchedNames = const $CopyWithPlaceholder(),
  }) {
    return FilterSettings(
      excludedNames:
          excludedNames == const $CopyWithPlaceholder() || excludedNames == null
          ? _value.excludedNames
          // ignore: cast_nullable_to_non_nullable
          : excludedNames as List<RegExp>,
      untouchedNames:
          untouchedNames == const $CopyWithPlaceholder() ||
              untouchedNames == null
          ? _value.untouchedNames
          // ignore: cast_nullable_to_non_nullable
          : untouchedNames as List<RegExp>,
    );
  }
}

extension $FilterSettingsCopyWith on FilterSettings {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFilterSettings.copyWith(...)` or `instanceOfFilterSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FilterSettingsCWProxy get copyWith => _$FilterSettingsCWProxyImpl(this);
}

abstract class _$ProgressCWProxy {
  Progress comicFiles(List<QueuedFile> comicFiles);

  Progress otherFiles(List<File> otherFiles);

  Progress comicFilesSize(int comicFilesSize);

  Progress otherFilesSize(int otherFilesSize);

  Progress inProgressIndecies(List<int> inProgressIndecies);

  Progress finishedCount(int finishedCount);

  Progress finishedSize(int finishedSize);

  Progress finishedOriginalSize(int finishedOriginalSize);

  Progress startTime(DateTime? startTime);

  Progress pauseTime(DateTime? pauseTime);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `Progress(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Progress(...).copyWith(id: 12, name: "My name")
  /// ```
  Progress call({
    List<QueuedFile> comicFiles,
    List<File> otherFiles,
    int comicFilesSize,
    int otherFilesSize,
    List<int> inProgressIndecies,
    int finishedCount,
    int finishedSize,
    int finishedOriginalSize,
    DateTime? startTime,
    DateTime? pauseTime,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfProgress.copyWith(...)` or call `instanceOfProgress.copyWith.fieldName(value)` for a single field.
class _$ProgressCWProxyImpl implements _$ProgressCWProxy {
  const _$ProgressCWProxyImpl(this._value);

  final Progress _value;

  @override
  Progress comicFiles(List<QueuedFile> comicFiles) =>
      call(comicFiles: comicFiles);

  @override
  Progress otherFiles(List<File> otherFiles) => call(otherFiles: otherFiles);

  @override
  Progress comicFilesSize(int comicFilesSize) =>
      call(comicFilesSize: comicFilesSize);

  @override
  Progress otherFilesSize(int otherFilesSize) =>
      call(otherFilesSize: otherFilesSize);

  @override
  Progress inProgressIndecies(List<int> inProgressIndecies) =>
      call(inProgressIndecies: inProgressIndecies);

  @override
  Progress finishedCount(int finishedCount) =>
      call(finishedCount: finishedCount);

  @override
  Progress finishedSize(int finishedSize) => call(finishedSize: finishedSize);

  @override
  Progress finishedOriginalSize(int finishedOriginalSize) =>
      call(finishedOriginalSize: finishedOriginalSize);

  @override
  Progress startTime(DateTime? startTime) => call(startTime: startTime);

  @override
  Progress pauseTime(DateTime? pauseTime) => call(pauseTime: pauseTime);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `Progress(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Progress(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  Progress call({
    Object? comicFiles = const $CopyWithPlaceholder(),
    Object? otherFiles = const $CopyWithPlaceholder(),
    Object? comicFilesSize = const $CopyWithPlaceholder(),
    Object? otherFilesSize = const $CopyWithPlaceholder(),
    Object? inProgressIndecies = const $CopyWithPlaceholder(),
    Object? finishedCount = const $CopyWithPlaceholder(),
    Object? finishedSize = const $CopyWithPlaceholder(),
    Object? finishedOriginalSize = const $CopyWithPlaceholder(),
    Object? startTime = const $CopyWithPlaceholder(),
    Object? pauseTime = const $CopyWithPlaceholder(),
  }) {
    return Progress(
      comicFiles:
          comicFiles == const $CopyWithPlaceholder() || comicFiles == null
          ? _value.comicFiles
          // ignore: cast_nullable_to_non_nullable
          : comicFiles as List<QueuedFile>,
      otherFiles:
          otherFiles == const $CopyWithPlaceholder() || otherFiles == null
          ? _value.otherFiles
          // ignore: cast_nullable_to_non_nullable
          : otherFiles as List<File>,
      comicFilesSize:
          comicFilesSize == const $CopyWithPlaceholder() ||
              comicFilesSize == null
          ? _value.comicFilesSize
          // ignore: cast_nullable_to_non_nullable
          : comicFilesSize as int,
      otherFilesSize:
          otherFilesSize == const $CopyWithPlaceholder() ||
              otherFilesSize == null
          ? _value.otherFilesSize
          // ignore: cast_nullable_to_non_nullable
          : otherFilesSize as int,
      inProgressIndecies:
          inProgressIndecies == const $CopyWithPlaceholder() ||
              inProgressIndecies == null
          ? _value.inProgressIndecies
          // ignore: cast_nullable_to_non_nullable
          : inProgressIndecies as List<int>,
      finishedCount:
          finishedCount == const $CopyWithPlaceholder() || finishedCount == null
          ? _value.finishedCount
          // ignore: cast_nullable_to_non_nullable
          : finishedCount as int,
      finishedSize:
          finishedSize == const $CopyWithPlaceholder() || finishedSize == null
          ? _value.finishedSize
          // ignore: cast_nullable_to_non_nullable
          : finishedSize as int,
      finishedOriginalSize:
          finishedOriginalSize == const $CopyWithPlaceholder() ||
              finishedOriginalSize == null
          ? _value.finishedOriginalSize
          // ignore: cast_nullable_to_non_nullable
          : finishedOriginalSize as int,
      startTime: startTime == const $CopyWithPlaceholder()
          ? _value.startTime
          // ignore: cast_nullable_to_non_nullable
          : startTime as DateTime?,
      pauseTime: pauseTime == const $CopyWithPlaceholder()
          ? _value.pauseTime
          // ignore: cast_nullable_to_non_nullable
          : pauseTime as DateTime?,
    );
  }
}

extension $ProgressCopyWith on Progress {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfProgress.copyWith(...)` or `instanceOfProgress.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProgressCWProxy get copyWith => _$ProgressCWProxyImpl(this);
}

abstract class _$QueuedFileCWProxy {
  QueuedFile relativePath(String relativePath);

  QueuedFile stage(PipelineStage stage);

  QueuedFile compressionStageRatio(double compressionStageRatio);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `QueuedFile(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QueuedFile(...).copyWith(id: 12, name: "My name")
  /// ```
  QueuedFile call({
    String relativePath,
    PipelineStage stage,
    double compressionStageRatio,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfQueuedFile.copyWith(...)` or call `instanceOfQueuedFile.copyWith.fieldName(value)` for a single field.
class _$QueuedFileCWProxyImpl implements _$QueuedFileCWProxy {
  const _$QueuedFileCWProxyImpl(this._value);

  final QueuedFile _value;

  @override
  QueuedFile relativePath(String relativePath) =>
      call(relativePath: relativePath);

  @override
  QueuedFile stage(PipelineStage stage) => call(stage: stage);

  @override
  QueuedFile compressionStageRatio(double compressionStageRatio) =>
      call(compressionStageRatio: compressionStageRatio);

  /// Creates a new instance with the provided field values.
  /// Omitted fields keep their values; explicit `null` clears nullable fields.
  /// The public API rejects `null` for non-nullable fields. To update a single field use `QueuedFile(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QueuedFile(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  QueuedFile call({
    Object? relativePath = const $CopyWithPlaceholder(),
    Object? stage = const $CopyWithPlaceholder(),
    Object? compressionStageRatio = const $CopyWithPlaceholder(),
  }) {
    return QueuedFile(
      relativePath:
          relativePath == const $CopyWithPlaceholder() || relativePath == null
          ? _value.relativePath
          // ignore: cast_nullable_to_non_nullable
          : relativePath as String,
      stage: stage == const $CopyWithPlaceholder() || stage == null
          ? _value.stage
          // ignore: cast_nullable_to_non_nullable
          : stage as PipelineStage,
      compressionStageRatio:
          compressionStageRatio == const $CopyWithPlaceholder() ||
              compressionStageRatio == null
          ? _value.compressionStageRatio
          // ignore: cast_nullable_to_non_nullable
          : compressionStageRatio as double,
    );
  }
}

extension $QueuedFileCopyWith on QueuedFile {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfQueuedFile.copyWith(...)` or `instanceOfQueuedFile.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QueuedFileCWProxy get copyWith => _$QueuedFileCWProxyImpl(this);
}
