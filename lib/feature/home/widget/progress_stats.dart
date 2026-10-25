import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/widget/custom_box.dart';
import '../../../core/widget/recursive_mubit_widget.dart';
import '../../../core/widget/titled_custom_box.dart';
import '../state/home_cubit.dart';
import '../state/home_data.dart';

class ProgressStats extends SelectingWidget<HomeCubit, HomeData, Progress?> {
  static Progress? _selector(HomeData state) => state.progress;
  static void _valueChanged(Progress? state) {}
  const new({super.key})
    : super(selector: _selector, valueChanged: _valueChanged);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return BlocSelector<HomeCubit, HomeData, bool>(
      selector: (state) => selector(state)!.comicFiles.isEmpty,
      builder: (context, state) => TitledCustomBox(
        title: "Stats",
        closedReason: "No files selected.",
        open: !state,
        child: Table(
          columnWidths: {
            0: MaxColumnWidth(FlexColumnWidth(), FixedColumnWidth(120)),
          },
          children: [
            TableRow(
              children: [
                Text("Non-comic files:", style: textTheme.labelLarge),
                Center(
                  child: BlocSelector<HomeCubit, HomeData, int>(
                    selector: (state) => selector(state)!.otherFiles.length,
                    builder: (context, state) => Text("$state files"),
                  ),
                ),
                Align(
                  alignment: .centerRight,
                  child: BlocSelector<HomeCubit, HomeData, int>(
                    selector: (state) => selector(state)!.otherFilesSize,
                    builder: (context, state) => Text(_sizeToString(state)),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text("Scanned:", style: textTheme.labelLarge),
                Center(
                  child: BlocSelector<HomeCubit, HomeData, int>(
                    selector: (state) => selector(state)!.comicFiles.length,
                    builder: (context, state) => Text("$state files"),
                  ),
                ),
                Align(
                  alignment: .centerRight,
                  child: BlocSelector<HomeCubit, HomeData, int>(
                    selector: (state) => selector(state)!.comicFilesSize,
                    builder: (context, state) => Text(_sizeToString(state)),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text("Not Started:", style: textTheme.labelLarge),
                Center(
                  child: BlocSelector<HomeCubit, HomeData, int>(
                    selector: (state) => selector(state)!.notStartedCount,
                    builder: (context, state) => Text("$state files"),
                  ),
                ),
                Center(),
              ],
            ),
            TableRow(
              children: [
                Text("In Progress:", style: textTheme.labelLarge),
                Center(
                  child: BlocSelector<HomeCubit, HomeData, int>(
                    selector: (state) =>
                        selector(state)!.inProgressIndecies.length,
                    builder: (context, state) => Text("$state files"),
                  ),
                ),
                Center(),
              ],
            ),
            TableRow(
              children: [
                Text("Done:", style: textTheme.labelLarge),
                Center(
                  child: BlocSelector<HomeCubit, HomeData, int>(
                    selector: (state) => selector(state)!.finishedCount,
                    builder: (context, state) => Text("$state files"),
                  ),
                ),
                Align(
                  alignment: .centerRight,
                  child: BlocSelector<HomeCubit, HomeData, (int, int)>(
                    selector: (state) => (
                      selector(state)!.finishedOriginalSize,
                      selector(state)!.finishedSize,
                    ),
                    builder: (context, state) => Text(
                      "${_sizeToString(state.$1)} -> ${_sizeToString(state.$2)}",
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text("Speed:", style: textTheme.labelLarge),
                Center(
                  child: BlocSelector<HomeCubit, HomeData, double?>(
                    selector: (state) => selector(state)!.filesPerSecond,
                    builder: (context, state) =>
                        state == null || state.isNaN || state.isInfinite
                        ? Text("...")
                        : Text("${state.toStringAsFixed(2)} files/s"),
                  ),
                ),
                Align(
                  alignment: .centerRight,
                  child: BlocSelector<HomeCubit, HomeData, double?>(
                    selector: (state) =>
                        selector(state)!.originalBytesPerSecond,
                    builder: (context, state) =>
                        state == null || state.isNaN || state.isInfinite
                        ? Text("...")
                        : Text("${_sizeToString(state)}/s"),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Text("Remaining Time:", style: textTheme.labelLarge),
                Center(
                  child: BlocSelector<HomeCubit, HomeData, double?>(
                    selector: (state) => selector(state)!.remainingSecondsFiles,
                    builder: (context, state) =>
                        state == null || state.isNaN || state.isInfinite
                        ? Text("...")
                        : Text(_secondsToString(state.toInt())),
                  ),
                ),
                Align(
                  alignment: .centerRight,
                  child: BlocSelector<HomeCubit, HomeData, double?>(
                    selector: (state) => selector(state)!.remainingSecondsBytes,
                    builder: (context, state) =>
                        state == null || state.isNaN || state.isInfinite
                        ? Text("...")
                        : Text(_secondsToString(state.toInt())),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _sizeToString(num? size) => switch (size) {
  null => "null B",
  < 10 => "${size.toStringAsFixed(2)} B",
  < 10000 => "${size.toInt()} B",
  < 10000000 => "${size ~/ 1024} KiB",
  < 10000000000 => "${size ~/ 1048576} MiB",
  < 10000000000000 => "${size ~/ 1073741824} GiB",
  _ => "${(size ~/ 1099511627776).toStringAsFixed(2)} GiB",
};

String _secondsToString(int? seconds) => switch (seconds) {
  null => "null",
  < 60 => "$seconds s",
  < 3600 => "${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, "0")}",
  < 86400 =>
    "${seconds ~/ 3600}:${((seconds % 3600) ~/ 60).toString().padLeft(2, "0")}:${(seconds % 60).toString().padLeft(2, "0")}",
  _ =>
    "${seconds ~/ 86400}:${((seconds % 86400) ~/ 3600).toString().padLeft(2, "0")}:${((seconds % 3600) ~/ 60).toString().padLeft(2, "0")}:${(seconds % 60).toString().padLeft(2, "0")}",
};
