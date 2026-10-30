import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../extensions/function_extension.dart';
import '../state/mubit.dart';
import 'controlled_text_form_field.dart';
import 'recursive_mubit_widget.dart';

class IntSlider<C extends Mubit<T>, T> extends SelectingWidget<C, T, int> {
  final String? title;
  final int min;
  final int max;
  const new({
    super.key,
    this.title,
    required this.min,
    required this.max,
    required super.selector,
    required super.valueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tileHeight,
      child: BlocSelector<C, T, int>(
        selector: selector,
        builder: (context, state) => Row(
          mainAxisSize: .max,
          children: [
            if (title != null)
              SizedBox(width: 64, child: Text(title!, maxLines: 1)),
            Expanded(
              child: Slider(
                value: state.toDouble(),
                min: min.toDouble(),
                max: max.toDouble(),
                divisions: max - min + 1,
                onChanged: (value) => valueChanged(value.toInt()),
              ),
            ),
            ControlledTextFormField(
              title: "",
              value: state.toString(),
              valueChanged: valueChanged.at(int.parse),
            ),
          ],
        ),
      ),
    );
  }
}

class DoubleSlider<C extends Mubit<T>, T>
    extends SelectingWidget<C, T, double> {
  final String? title;
  final double min;
  final double max;
  final int divisions;
  const new({
    super.key,
    this.title,
    required this.min,
    required this.max,
    required this.divisions,
    required super.selector,
    required super.valueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tileHeight,
      child: BlocSelector<C, T, double>(
        selector: selector,
        builder: (context, state) => Row(
          mainAxisSize: .max,
          children: [
            if (title != null)
              SizedBox(width: 60, child: Text(title!, maxLines: 1)),
            Flexible(
              child: Slider(
                value: state,
                min: min,
                max: max,
                divisions: divisions,
                onChanged: valueChanged,
              ),
            ),
            ControlledTextFormField(
              title: "",
              value: state.toString(),
              valueChanged: valueChanged.at(double.parse),
            ),
          ],
        ),
      ),
    );
  }
}
