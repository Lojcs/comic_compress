import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:window_manager/window_manager.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/function_extension.dart';
import '../../../core/widget/controlled_text_form_field.dart';
import '../../../core/widget/custom_box.dart';
import '../../../core/widget/custom_button.dart';
import '../../../core/widget/custom_slider.dart';
import '../../../core/widget/custom_switch_tile.dart';
import '../../../core/widget/file_box.dart';
import '../../../core/widget/recursive_mubit_widget.dart';
import '../../info/widget/info_dialog.dart';
import '../state/home_cubit.dart';
import '../state/home_data.dart';
import 'compression_settings_box.dart';
import 'misc_settings_box.dart';
import 'progress_stats.dart';
import 'progress_queue.dart';

enum HomeScreenState { initial, folderOpen, running }

class HomeScreen extends ProvidingWidget<HomeCubit, HomeData> {
  static const double minWidth = 516;
  static const double maxWidth = 1032;
  static const double minHeight = 640;
  static const double folderHeight = 148;
  static const double runningHeight = 160;
  static Size size(ImageSettings settings, HomeScreenState state) => Size(
    minWidth,
    minHeight +
        (state == .running
            ? 96
            : settings.settingCount * tileHeightWithPadding) +
        (state != .initial ? folderHeight : 0),
  );
  static const maxSize = Size(maxWidth, 10000);
  static const minSize = Size(516, 500);
  new({super.key}) : super(cubit: HomeCubit());

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size(double.infinity, 48),
        //   child: Center(
        //     child: Text("Comic Compress", style: context.textTheme.titleLarge),
        //   ),
        // ),
        // appBar: AppBar(centerTitle: true, title: Text("Comic Compress")),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: maxWidth,
              child: Padding(
                padding: .all(8),
                child: Column(
                  spacing: 8,
                  children: [
                    Wrap(
                      runAlignment: .center,
                      alignment: .center,
                      crossAxisAlignment: .center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        SizedBox(
                          width: 64,
                          height: 86,
                          child: CustomButton(
                            text: "Info",
                            icon: Icons.help_rounded,
                            iconAxis: .vertical,
                            padding: .symmetric(horizontal: 16, vertical: 12),
                            borderRadius: .circular(12),
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) => BlocProvider.value(
                                value: cubit,
                                child: InfoDialog(),
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: customBoxWidth - 72,
                          ),
                          child: BlocSelector<HomeCubit, HomeData, bool>(
                            selector: (state) => state.pipelineState.started,
                            builder: (context, state) =>
                                FileBox<HomeCubit, HomeData>(
                                  selector: (state) => state.source,
                                  valueChanged: cubit.setSource,
                                  title: "Source Folder",
                                  enabled: !state,
                                ),
                          ),
                        ),
                        BlocSelector<HomeCubit, HomeData, bool>(
                          selector: (state) => state.pipelineState.started,
                          builder: (context, state) =>
                              FileBox<HomeCubit, HomeData>(
                                selector: (state) => state.destination,
                                valueChanged: cubit.mutate
                                    .by((a) => a.copyWith.destination)
                                    .at((s) => s!),
                                title: "Destination Folder",
                                enabled: !state,
                              ),
                        ),
                        ImageSettingsBox(
                          valueChanged: cubit.mutate.by(
                            (e) => e.copyWith.imageSettings,
                          ),
                        ),
                        MiscSettingsBox(
                          valueChanged: cubit.mutate.by(
                            (e) => e.copyWith.miscSettings,
                          ),
                        ),
                        QueueBox(),
                        ProgressStats(),
                      ],
                    ),
                    BlocSelector<HomeCubit, HomeData, bool>(
                      selector: (state) => state.pipelineState.started,
                      builder: (context, state) => state
                          ? Row(
                              mainAxisSize: .min,
                              children: [
                                BlocSelector<HomeCubit, HomeData, bool>(
                                  selector: (state) =>
                                      state.pipelineState.paused,
                                  builder: (context, state) => CustomButton(
                                    text: state ? "Resume" : "Gradual Pause",
                                    icon: state
                                        ? Icons.play_arrow_rounded
                                        : Icons.pause,
                                    padding: .symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    borderRadius: .horizontal(
                                      left: .circular(12),
                                    ),
                                    onTap: state
                                        ? cubit.resumeCompression
                                        : cubit.pauseCompression,
                                  ),
                                ),
                                CustomButton(
                                  text: "Stop",
                                  icon: Icons.stop,
                                  padding: .symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  borderRadius: .horizontal(
                                    right: .circular(12),
                                  ),
                                  onTap: cubit.stopCompression,
                                ),
                              ],
                            )
                          : BlocSelector<HomeCubit, HomeData, bool>(
                              selector: (state) =>
                                  state.progress.comicFiles.isNotEmpty,
                              builder: (context, state) => CustomButton(
                                text: "Start",
                                icon: Icons.play_arrow_rounded,
                                padding: .symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                borderRadius: .circular(12),
                                onTap: cubit.startCompression,
                                enabled: state,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
