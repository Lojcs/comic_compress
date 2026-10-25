import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/function_extension.dart';
import '../../../core/widget/controlled_text_form_field.dart';
import '../../../core/widget/custom_box.dart';
import '../../../core/widget/custom_button.dart';
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
            _FilterOutNames(
              selector: (state) => selector(state).filterSettings,
              valueChanged: (value) =>
                  valueChanged(val(context).copyWith.filterSettings(value)),
            ),
            CustomSwitchTile<HomeCubit, HomeData>(
              title: "Normalize Image Names",
              selector: (state) => selector(state).normalizeImageNames,
              valueChanged: (value) {
                valueChanged(val(context).copyWith.normalizeImageNames(value));
                if (!value) valueChanged(val(context).copyWith.flatten(false));
              },
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

class _FilterOutNames
    extends SelectingWidget<HomeCubit, HomeData, FilterSettings> {
  const new({super.key, required super.selector, required super.valueChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text("Archive Filter"),
        CustomButton(
          text: "Modify",
          padding: .symmetric(horizontal: 4),
          onTap: () {
            final cubit = context.read<HomeCubit>();
            showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                value: cubit,
                child: _FilterOutNamesDialog(
                  selector: selector,
                  valueChanged: valueChanged,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FilterOutNamesDialog
    extends SelectingWidget<HomeCubit, HomeData, FilterSettings> {
  const new({super.key, required super.selector, required super.valueChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Dialog(
      backgroundColor: context.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: .circular(8)),
      child: Padding(
        padding: .all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            spacing: 8,
            children: [
              Text("Archive Filter", style: textTheme.titleMedium),
              Text("""Rules to apply to the files and folders in the comic archives.
They are applied before renaming / flattenning operations.
If a folder is matched all items in it will be affected."""),
              _RegexList(
                title: "Excluded regex patterns",
                description: "Remove these from the archive.",
                presets: [
                  (name: "Hidden Files", value: RegExp("^\\.")),
                  (name: "__MACOSX", value: RegExp("^__MACOSX\$")),
                ],
                selector: (state) => selector(state).excludedNames,
                valueChanged: (value) =>
                    valueChanged(val(context).copyWith.excludedNames(value)),
              ),
              _RegexList(
                title: "Untouched regex patterns",
                description: """Don't compress or rename these files.
Compression removes files if they aren't images.""",
                presets: [
                  (name: "ComicInfo.xml", value: RegExp("^ComicInfo\\.xml\$")),
                ],
                selector: (state) => selector(state).untouchedNames,
                valueChanged: (value) =>
                    valueChanged(val(context).copyWith.untouchedNames(value)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegexList extends SelectingWidget<HomeCubit, HomeData, List<RegExp>> {
  final String title;
  final String? description;
  final List<({String name, RegExp value})> presets;
  const new({
    super.key,
    required this.title,
    this.description,
    required this.presets,
    required super.selector,
    required super.valueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      type: .accent,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: context.textTheme.titleSmall),
          if (description != null) Text(description!),
          SizedBox(
            height: 150,
            child: BlocSelector<HomeCubit, HomeData, List<RegExp>>(
              selector: selector,
              builder: (context, state) => ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) => Padding(
                  padding: .symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      Text("${index + 1}"),
                      SizedBox(
                        width: 300,
                        child: ControlledTextFormField(
                          alignment: .start,
                          value: state[index].pattern,
                          valueChanged: (value) =>
                              valueChanged([...state]..[index] = RegExp(value)),
                        ),
                      ),
                      IconButton(
                        iconSize: 20,
                        padding: .zero,
                        visualDensity: VisualDensity(
                          horizontal: -4.0,
                          vertical: -4.0,
                        ),
                        onPressed: () =>
                            valueChanged([...state]..removeAt(index)),
                        icon: Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: .center,
            children: [
              CustomButton(
                text: "Blank",
                icon: Icons.add,
                iconSize: 20,
                padding: .symmetric(horizontal: 12, vertical: 8),
                borderRadius: .horizontal(left: .circular(12)),
                onTap: () => valueChanged([...val(context), RegExp("")]),
              ),
              ...presets.mapIndexed(
                (i, e) => CustomButton(
                  text: e.name,
                  padding: .symmetric(horizontal: 12, vertical: 8),
                  borderRadius: i == presets.length - 1
                      ? .horizontal(right: .circular(12))
                      : .zero,
                  onTap: () => valueChanged([...val(context), e.value]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
