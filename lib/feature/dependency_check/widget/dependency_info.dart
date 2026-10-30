import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/widget/custom_box.dart';
import '../../../core/widget/recursive_mubit_widget.dart';
import '../state/dependency_check_cubit.dart';
import '../state/dependency_check_data.dart';

class DependencyInfo extends StatelessWidget {
  final String title;
  final String library;
  final String purpose;
  final bool state;
  const new({
    super.key,
    required this.title,
    required this.library,
    required this.purpose,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return CustomBox(
      child: Row(
        spacing: 8,
        children: [
          SizedBox(
            width: 80,
            child: Column(
              children: [
                Icon(state ? Icons.check : Icons.question_mark, size: 32),
                Text(state ? "Found" : "Missing", style: textTheme.titleSmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(title, style: textTheme.titleMedium),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Library: ", style: textTheme.titleSmall),
                    TextSpan(text: library),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "Purpose: ", style: textTheme.titleSmall),
                    TextSpan(text: purpose),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _noOp<T>(T _) {}

class CjxlInfo
    extends SelectingWidget<DependencyCheckCubit, DependencyCheckData, bool> {
  static bool _selector(DependencyCheckData state) => state.cjxlAvailable;
  const new({super.key}) : super(selector: _selector, valueChanged: _noOp);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DependencyCheckCubit, DependencyCheckData, bool>(
      selector: selector,
      builder: (context, state) => DependencyInfo(
        title: "cjxl",
        library: "libjxl",
        purpose: "JpegXL encoding.",
        state: state,
      ),
    );
  }
}

class CwebpInfo
    extends SelectingWidget<DependencyCheckCubit, DependencyCheckData, bool> {
  static bool _selector(DependencyCheckData state) => state.cwebpAvailable;
  const new({super.key}) : super(selector: _selector, valueChanged: _noOp);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DependencyCheckCubit, DependencyCheckData, bool>(
      selector: selector,
      builder: (context, state) => DependencyInfo(
        title: "cwebp",
        library: "libwebp",
        purpose: "WebP encoding.",
        state: state,
      ),
    );
  }
}

class ExiftoolInfo
    extends SelectingWidget<DependencyCheckCubit, DependencyCheckData, bool> {
  static bool _selector(DependencyCheckData state) => state.exiftoolAvailable;
  const new({super.key}) : super(selector: _selector, valueChanged: _noOp);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DependencyCheckCubit, DependencyCheckData, bool>(
      selector: selector,
      builder: (context, state) => DependencyInfo(
        title: "exiftool",
        library: "exiftool",
        purpose: "Fixing image metadata.",
        state: state,
      ),
    );
  }
}
