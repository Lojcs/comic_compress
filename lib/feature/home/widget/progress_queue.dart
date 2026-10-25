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
            height: 244,
            child: ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) => Padding(
                padding: .symmetric(vertical: 1.5),
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
            width: 275,
            child: BlocSelector<HomeCubit, HomeData, String>(
              selector: (state) =>
                  state.progress!.comicFiles[index].relativePath,
              builder: (context, state) =>
                  Text(path.basename(state), style: textTheme.labelSmall),
            ),
          ),
          SizedBox(
            width: 160,
            height: 32,
            child: Stack(
              alignment: .center,
              children: [
                BlocSelector<HomeCubit, HomeData, double>(
                  selector: (state) =>
                      state.progress!.comicFiles[index].compressionStageRatio,
                  builder: (context, state) => LinearProgressIndicator(
                    minHeight: 28,
                    borderRadius: .circular(8),
                    value: state,
                    backgroundColor: context.colorScheme.surfaceContainerLow,
                    color: context.colorScheme.secondaryContainer,
                  ),
                ),
                BlocSelector<HomeCubit, HomeData, PipelineStage>(
                  selector: (state) => state.progress!.comicFiles[index].stage,
                  builder: (context, state) => Text(switch (state) {
                    .queued => "0 / 7 Queued",
                    .copy => "1 / 7 Copying",
                    .unpack => "2 / 7 Unpacking",
                    .filter => "3 / 7 Filtering",
                    .compress => "4 / 7 Compressing",
                    .repack => "5 / 7 Repacking",
                    .move => "6 / 7 Moving",
                    .finished => "7 / 7 Finished",
                  }, style: textTheme.bodySmall),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
