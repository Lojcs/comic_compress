import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/function_extension.dart';
import '../../../core/widget/custom_box.dart';
import '../../../core/widget/custom_slider.dart';
import '../../../core/widget/recursive_mubit_widget.dart';
import '../../../core/widget/titled_custom_box.dart';
import '../state/home_cubit.dart';
import '../state/home_data.dart';

class ImageSettingsBox
    extends SelectingWidget<HomeCubit, HomeData, ImageSettings> {
  static ImageSettings _selector(HomeData state) => state.imageSettings;
  const new({super.key, required super.valueChanged})
    : super(selector: _selector);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return BlocSelector<HomeCubit, HomeData, bool>(
      selector: (state) => !state.pipelineState.started,
      builder: (context, state) => TitledCustomBox(
        title: "Image Compression Settings",
        closedReason: "Compression has started.",
        open: state,
        child: BlocSelector<HomeCubit, HomeData, ImageCodec>(
          selector: (state) => selector(state).codec,
          builder: (context, state) => Column(
            crossAxisAlignment: .start,
            spacing: 8,
            children: [
              SizedBox(
                height: tileHeight,
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text("Codec"),
                    DropdownButton<ImageCodec>(
                      value: state,
                      isDense: true,
                      underline: Center(),
                      items: [
                        DropdownMenuItem(
                          value: .jxl,
                          child: Text("Jxl", style: textTheme.bodyMedium),
                        ),
                        DropdownMenuItem(
                          value: .webp,
                          child: Text("WebP", style: textTheme.bodyMedium),
                        ),
                        DropdownMenuItem(
                          value: .webpLossless,
                          child: Text(
                            "WebP (Lossless)",
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      ],
                      onChanged: (value) =>
                          context.read<HomeCubit>().setCodec(value!),
                    ),
                  ],
                ),
              ),
              switch (state) {
                .jxl => _JxlImageSettingsBody(valueChanged: valueChanged),
                .webp => _WebpImageSettingsBody(valueChanged: valueChanged),
                .webpLossless => _WebpLosslessImageSettingsBody(
                  valueChanged: valueChanged,
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

class _JxlImageSettingsBody
    extends SelectingWidget<HomeCubit, HomeData, JxlImageSettings> {
  static JxlImageSettings _selector(HomeData state) =>
      switch (state.imageSettings) {
        JxlImageSettings settings => settings,
        _ => JxlImageSettings.blank(),
      };
  const new({super.key, required super.valueChanged})
    : super(selector: _selector);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        DoubleSlider<HomeCubit, HomeData>(
          title: "Distance",
          min: 0,
          max: 10,
          divisions: 20,
          selector: (state) => selector(state).distance,
          valueChanged: (value) =>
              valueChanged(val(context).copyWith.distance(value)),
        ),
        IntSlider<HomeCubit, HomeData>(
          title: "Effort",
          min: 1,
          max: 9,
          selector: (state) => selector(state).effort,
          valueChanged: (value) =>
              valueChanged(val(context).copyWith.effort(value)),
        ),
      ],
    );
  }
}

class _WebpPresetSelector
    extends SelectingWidget<HomeCubit, HomeData, WebpPreset> {
  static WebpPreset _selector(HomeData state) => switch (state.imageSettings) {
    WebpImageSettings settings => settings.preset,
    _ => .none,
  };
  const new({super.key, required super.valueChanged})
    : super(selector: _selector);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text("Preset"),
        BlocSelector<HomeCubit, HomeData, WebpPreset>(
          selector: selector,
          builder: (context, state) => DropdownButton<WebpPreset>(
            value: state,
            isDense: true,
            underline: Center(),
            items: [
              DropdownMenuItem(
                value: .none,
                child: Text("Default", style: textTheme.bodyMedium),
              ),
              DropdownMenuItem(
                value: .photo,
                child: Text("Photo", style: textTheme.bodyMedium),
              ),
              DropdownMenuItem(
                value: .picture,
                child: Text("Picture", style: textTheme.bodyMedium),
              ),
              DropdownMenuItem(
                value: .drawing,
                child: Text("Drawing", style: textTheme.bodyMedium),
              ),
              DropdownMenuItem(
                value: .icon,
                child: Text("Icon", style: textTheme.bodyMedium),
              ),
              DropdownMenuItem(
                value: .text,
                child: Text("Text", style: textTheme.bodyMedium),
              ),
            ],
            onChanged: valueChanged.at((s) => s!),
          ),
        ),
      ],
    );
  }
}

class _WebpImageSettingsBody
    extends SelectingWidget<HomeCubit, HomeData, WebpImageSettings> {
  static WebpImageSettings _selector(HomeData state) =>
      switch (state.imageSettings) {
        WebpImageSettings settings => settings,
        _ => WebpImageSettings.blank(),
      };
  const new({super.key, required super.valueChanged})
    : super(selector: _selector);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        _WebpPresetSelector(
          valueChanged: (value) =>
              valueChanged(val(context).copyWith.preset(value)),
        ),
        IntSlider<HomeCubit, HomeData>(
          title: "Quality",
          min: 0,
          max: 100,
          selector: (state) => selector(state).quality,
          valueChanged: (value) =>
              valueChanged(val(context).copyWith.quality(value)),
        ),
        IntSlider<HomeCubit, HomeData>(
          title: "Effort",
          min: 0,
          max: 6,
          selector: (state) => selector(state).effort,
          valueChanged: (value) =>
              valueChanged(val(context).copyWith.effort(value)),
        ),
      ],
    );
  }
}

class _WebpLosslessImageSettingsBody
    extends SelectingWidget<HomeCubit, HomeData, WebpLosslessImageSettings> {
  static WebpLosslessImageSettings _selector(HomeData state) =>
      switch (state.imageSettings) {
        WebpLosslessImageSettings settings => settings,
        _ => WebpLosslessImageSettings.blank(),
      };
  const new({super.key, required super.valueChanged})
    : super(selector: _selector);

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        _WebpPresetSelector(
          valueChanged: (value) =>
              valueChanged(val(context).copyWith.preset(value)),
        ),
        IntSlider<HomeCubit, HomeData>(
          title: "Effort",
          min: 0,
          max: 9,
          selector: (state) => selector(state).effort,
          valueChanged: (value) =>
              valueChanged(val(context).copyWith.effort(value)),
        ),
      ],
    );
  }
}
