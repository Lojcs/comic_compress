import 'dart:collection';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as path;
import 'package:unrar/unrar.dart';

import '../../../../core/util/isolated.dart';
import '../../../../core/util/processr.dart';
import '../home_cubit.dart';
import '../home_data.dart';
import 'pipeline_manager.dart';

class CompressionPipeline {
  final HomeCubit cubit;
  final Directory tempDir;
  final int index;
  final void Function(PipelineJob? job) addNewJob;

  new _({
    required this.cubit,
    required this.tempDir,
    required this.index,
    required this.addNewJob,
  });

  /// Creates a new pipeline and adds its first job;
  static void start(
    HomeCubit cubit,
    Directory tempDir,
    void Function(PipelineJob? job) addNewJob, {
    bool orStop = false,
  }) {
    final index = cubit.getNextIndex();
    if (index != null) {
      final pipeline = CompressionPipeline._(
        cubit: cubit,
        tempDir: tempDir,
        index: index,
        addNewJob: addNewJob,
      );
      addNewJob(pipeline.copy);
    } else if (orStop) {
      addNewJob(null);
    }
  }

  late final relativePath =
      cubit.state.progress!.comicFiles[index].relativePath;
  late final relativePathNoExtension = path.withoutExtension(relativePath);
  late final extension = path.extension(relativePath);
  late final relativePathArchiveExtension = path.setExtension(
    relativePathNoExtension,
    extension == ".cbr" ? ".rar" : ".zip",
  );
  late final relativePathCbz = path.setExtension(
    relativePathNoExtension,
    ".cbz",
  );

  late final sourcePath = path.join(cubit.state.source!.path, relativePath);
  late final copyPath = path.join(tempDir.path, relativePathArchiveExtension);
  late final unpackPath = path.join(tempDir.path, relativePathNoExtension);
  late final repackPath = path.join(tempDir.path, relativePathCbz);
  late final destinationPath = path.join(
    cubit.state.destination.path,
    relativePathCbz,
  );

  late final int imageCount;
  late final double ratioPerImage = 1 / imageCount;
  int compressedImageCount = 0;

  /// Copies the issue to the temporary directory.
  Future<void> copy(Isolated isolate) async {
    await cubit.changeStage(index, .copy);
    await isolate.run(_copy, (from: sourcePath, to: copyPath));
    addNewJob(unpack);
  }

  /// Unpacks file into a directory.
  Future<void> unpack(Isolated isolate) async {
    await cubit.changeStage(index, .unpack);
    await isolate.run(_unpack, (from: copyPath, to: unpackPath));
    addNewJob(filter);
  }

  /// Chmods to 777.
  /// Removes non-image, non xml files.
  /// Also flattens archive hierarchy and/or filters out hidden images.
  Future<void> filter(Isolated isolate) async {
    await cubit.changeStage(index, .filter);
    // await _filter((
    //   path: unpackPath,
    //   tempPath: tempDir.path,
    //   includeHidden: cubit.state.miscSettings.includeHidden,
    //   normalizeImageNames: cubit.state.miscSettings.normalizeImageNames,
    //   flatten: cubit.state.miscSettings.flatten,
    // ));
    await isolate.run(_filter, (
      path: unpackPath,
      tempPath: tempDir.path,
      includeHidden: cubit.state.miscSettings.includeHidden,
      normalizeImageNames: cubit.state.miscSettings.normalizeImageNames,
      flatten: cubit.state.miscSettings.flatten,
    ));
    await dispatchCompress();
  }

  /// Dispatches a compress job for each image.
  Future<void> dispatchCompress() async {
    final images = await Directory(unpackPath)
        .list(recursive: true)
        .where(
          (entity) => entity is File && path.extension(entity.path) != ".xml",
        )
        .toList();
    imageCount = images.length;
    for (final image in images) {
      addNewJob(compress(image.path));
    }
  }

  /// Compresses an image.
  PipelineJob compress(String filePath) => (isolate) async {
    await cubit.changeStage(
      index,
      .compress,
      compressedImageCount * ratioPerImage,
    );
    await isolate.run(_compress, (
      filePath: filePath,
      settings: cubit.state.imageSettings,
    ));
    // await _compress((filePath: filePath, settings: cubit.state.imageSettings));
    compressedImageCount++;
    await cubit.changeStage(
      index,
      .compress,
      compressedImageCount * ratioPerImage,
    );
    if (compressedImageCount == imageCount) addNewJob(repack);
  };

  /// Repacks directory into cbz.
  Future<void> repack(Isolated isolate) async {
    await cubit.changeStage(index, .repack);
    await isolate.run(_repack, (from: unpackPath, to: repackPath));
    addNewJob(move);
  }

  /// Moves file to the destination directory.
  /// Starts the next pipeline.
  Future<void> move(Isolated isolate) async {
    await cubit.changeStage(index, .move);
    await isolate.run(_move, (from: repackPath, to: destinationPath));
    await cubit.changeStage(index, .finished);
    CompressionPipeline.start(cubit, tempDir, addNewJob, orStop: true);
  }

  static Future<void> _copy(({String from, String to}) args) async {
    await File(args.to).create(recursive: true);
    await File(args.from).copy(args.to);
  }

  static Future<void> _unpack(({String from, String to}) args) async {
    if (path.extension(args.from) == ".rar") {
      UnrarExtractor().extractAll(args.from, args.to);
    } else {
      await extractFileToDisk(args.from, args.to);
    }
    await File(args.from).delete();
  }

  static Future<void> _filter(
    ({
      String path,
      String tempPath,
      bool includeHidden,
      bool normalizeImageNames,
      bool flatten,
    })
    args,
  ) async {
    const acceptedFileExtensions = [
      ".jpg",
      ".jpeg",
      ".png",
      ".webp",
      ".jxl",
      ".xml",
    ];
    await Process.run("chmod", ["777", "-R", args.path]);
    final dir = Directory(args.path);
    final tmp = await Directory(args.tempPath).createTemp();
    await tmp.delete();
    await dir.rename(tmp.path);
    final files = await tmp.list(recursive: true).toList();
    for (var file in files) {
      if (file is! File) continue;
      if (acceptedFileExtensions.contains(
            path.extension(file.path).toLowerCase(),
          ) &&
          (args.includeHidden ||
              path
                  .split(path.relative(file.path, from: tmp.path))
                  .none((e) => e.startsWith(".")))) {
        final String newPath;
        if (args.flatten) {
          final basename = path.basename(file.path);
          newPath = path.join(args.path, basename);
        } else {
          final relativePath = path.relative(file.path, from: tmp.path);
          newPath = path.join(args.path, relativePath);
        }
        final renamedFile = File(newPath);
        await renamedFile.create(recursive: true);
        await renamedFile.delete();
        await file.rename(newPath);
      }
    }
    await tmp.delete(recursive: true);
  }

  static Future<void> _compress(
    ({String filePath, ImageSettings settings}) args,
  ) async {
    final extensionlessPath = path.withoutExtension(args.filePath);
    final ProcessResult result;
    switch (args.settings.codec) {
      case .jxl:
        final settings = args.settings as JxlImageSettings;
        final extension = path.extension(args.filePath).toLowerCase();
        final losslessJpeg =
            settings.distance == 0 &&
            (extension == "jpeg" || extension == "jpg");
        final destinationPath = path.setExtension(extensionlessPath, ".jxl");
        result = await Processr.run("cjxl", [
          "-e",
          "${settings.effort}",
          "-d",
          "${settings.distance}",
          "-e",
          "${settings.effort}",
          "--num_threads",
          "0",
          "--lossless_jpeg",
          losslessJpeg ? "1" : "0",
          args.filePath,
          extensionlessPath,
        ]);
        await File(args.filePath).delete();
        final extensionlessFile = File(extensionlessPath);
        if (await extensionlessFile.exists()) {
          await extensionlessFile.rename(destinationPath);
        }
      case .webp:
        final settings = args.settings as WebpImageSettings;
        final destinationPath = path.setExtension(extensionlessPath, ".webp");
        result = await Processr.run("cwebp", [
          "-preset",
          settings.preset.name,
          "-q",
          "${settings.quality}",
          "-m",
          "${settings.effort}",
          args.filePath,
          "-o",
          destinationPath,
        ]);
        await File(args.filePath).delete();
        final extensionlessFile = File(extensionlessPath);
        if (await extensionlessFile.exists()) {
          await extensionlessFile.rename(destinationPath);
        }
      case .webpLossless:
        final settings = args.settings as WebpLosslessImageSettings;
        final destinationPath = path.setExtension(extensionlessPath, ".webp");
        result = await Processr.run("cwebp", [
          "-preset",
          settings.preset.name,
          "-lossless",
          "-z",
          "${settings.effort}",
          args.filePath,
          "-o",
          destinationPath,
        ]);
        await File(args.filePath).delete();
        final extensionlessFile = File(extensionlessPath);
        if (await extensionlessFile.exists()) {
          await extensionlessFile.rename(destinationPath);
        }
      case .cjpeg:
        final settings = args.settings.codec as CJpegImageSettings;
        final destinationPath = path.setExtension(extensionlessPath, ".jpg");
        result = await Processr.run("cjxl", [
          "-quality",
          "${settings.quality}",
          args.filePath,
          "-outfile",
          destinationPath,
        ]);
        await File(args.filePath).delete();
        final extensionlessFile = File(extensionlessPath);
        if (await extensionlessFile.exists()) {
          await extensionlessFile.rename(destinationPath);
        }
    }
  }

  static Future<void> _repack(({String from, String to}) args) async {
    final fromDir = Directory(args.from);
    await ZipFileEncoder().zipDirectory(fromDir, filename: args.to);
    await fromDir.delete(recursive: true);
  }

  static Future<void> _move(({String from, String to}) args) async {
    final fromFile = File(args.from);
    final toFile = File(args.to);
    await toFile.create(recursive: true);
    await fromFile.copy(args.to);
    await fromFile.delete();
  }
}
