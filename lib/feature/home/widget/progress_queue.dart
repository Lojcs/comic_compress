import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

import '../../../core/extensions/context_extension.dart';
import '../../../core/widget/custom_box.dart';
import '../../../core/widget/recursive_mubit_widget.dart';
import '../../../core/widget/titled_custom_box.dart';
import '../state/home_cubit.dart';
import '../state/home_data.dart';

class QueueBox extends SelectingWidget<HomeCubit, HomeData, Progress?> {
  static Progress? _selector(HomeData state) => state.progress;
  static void _valueChanged(Progress? state) {}
  const new({super.key})
    : super(selector: _selector, valueChanged: _valueChanged);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeData, bool>(
      selector: (state) => state.pipelineState.started,
      builder: (context, state) => TitledCustomBox(
        title: "Queue",
        closedReason: "Compression not started.",
        open: state,
        child: BlocSelector<HomeCubit, HomeData, List<int>>(
          selector: (state) => selector(state)!.inProgressIndecies,
          builder: (context, state) => SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) => Padding(
                padding: .symmetric(vertical: 4),
                child: _QueueItem(index: state[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QueueItem extends StatelessWidget {
  final int index;

  const new({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return CustomBox(
      type: .accent,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: BlocSelector<HomeCubit, HomeData, String>(
              selector: (state) =>
                  state.progress!.comicFiles[index].relativePath,
              builder: (context, state) =>
                  Text(path.basename(state), style: textTheme.labelMedium),
            ),
          ),
          SizedBox(
            width: 200,
            child: Stack(
              alignment: .center,
              children: [
                BlocSelector<HomeCubit, HomeData, double>(
                  selector: (state) =>
                      state.progress!.comicFiles[index].compressionStageRatio,
                  builder: (context, state) => LinearProgressIndicator(
                    minHeight: 48,
                    borderRadius: .circular(8),
                    value: state,
                  ),
                ),
                BlocSelector<HomeCubit, HomeData, PipelineStage>(
                  selector: (state) => state.progress!.comicFiles[index].stage,
                  builder: (context, state) => switch (state) {
                    .queued => Column(
                      children: [Text("0 / 7"), Text("Queued")],
                    ),
                    .copy => Column(children: [Text("1 / 7"), Text("Copying")]),
                    .unpack => Column(
                      children: [Text("2 / 7"), Text("Unpacking")],
                    ),
                    .filter => Column(
                      children: [Text("3 / 7"), Text("Filtering")],
                    ),
                    .compress => Column(
                      children: [Text("4 / 7"), Text("Compressing")],
                    ),
                    .repack => Column(
                      children: [Text("5 / 7"), Text("Repacking")],
                    ),
                    .move => Column(children: [Text("6 / 7"), Text("Moving")]),
                    .finished => Column(
                      children: [Text("7 / 7"), Text("Finished")],
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
