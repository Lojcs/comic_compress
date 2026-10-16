import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/function_extension.dart';
import '../../../core/widget/controlled_text_form_field.dart';
import '../../../core/widget/custom_box.dart';
import '../../../core/widget/custom_slider.dart';
import '../../../core/widget/custom_switch_tile.dart';
import '../../../core/widget/recursive_mubit_widget.dart';
import '../../../core/widget/titled_custom_box.dart';
import '../state/home_cubit.dart';
import '../state/home_data.dart';

class MiscSettingsBox
    extends SelectingWidget<HomeCubit, HomeData, MiscSettings> {
  static MiscSettings _selector(HomeData state) => state.miscSettings;
  const new({super.key, required super.valueChanged})
    : super(selector: _selector);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeData, bool>(
      selector: (state) => !state.pipelineState.started,
      builder: (context, state) => TitledCustomBox(
        title: "Miscellaneous Settings",
        closedReason: "Compression has started.",
        open: state,
        child: Column(
          crossAxisAlignment: .start,
          spacing: 8,
          children: [
            CustomSwitchTile<HomeCubit, HomeData>(
              title: "Normalize Image Names",
              selector: (state) => selector(state).normalizeImageNames,
              valueChanged: (value) => valueChanged(
                val(context).copyWith.normalizeImageNames(value),
              ),
            ),
            BlocSelector<HomeCubit, HomeData, bool>(
              selector: (state) => selector(state).normalizeImageNames,
              builder: (context, state) =>
                  CustomSwitchTile<HomeCubit, HomeData>(
                    title: "Flatten Archive Hierarchy",
                    selector: (state) => selector(state).flatten,
                    valueChanged: (value) =>
                        valueChanged(val(context).copyWith.flatten(value)),
                    enabled: state,
                  ),
            ),
            CustomSwitchTile<HomeCubit, HomeData>(
              title: "Include Hidden Images",
              selector: (state) => selector(state).includeHidden,
              valueChanged: (value) =>
                  valueChanged(val(context).copyWith.includeHidden(value)),
            ),
            BlocSelector<HomeCubit, HomeData, int>(
              selector: (state) => selector(state).threadCount,
              builder: (context, state) => ControlledTextFormField(
                title: "Thread Count",
                value: state.toString(),
                valueChanged: (value) => valueChanged(
                  val(context).copyWith.threadCount(int.parse(value)),
                ),
              ),
            ),
            CustomSwitchTile<HomeCubit, HomeData>(
              title: "Copy Non-Comic Files",
              selector: (state) => selector(state).copyNonComicFiles,
              valueChanged: (value) =>
                  valueChanged(val(context).copyWith.copyNonComicFiles(value)),
            ),
            IntSlider<HomeCubit, HomeData>(
              title: "Zip Effort",
              min: 0,
              max: 9,
              selector: (state) => selector(state).zipEffort,
              valueChanged: (value) =>
                  valueChanged(val(context).copyWith.zipEffort(value)),
            ),
          ],
        ),
      ),
    );
  }
}
