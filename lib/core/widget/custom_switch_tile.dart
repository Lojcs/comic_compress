import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/home/state/home_cubit.dart';
import '../../feature/home/state/home_data.dart';
import '../constants.dart';
import '../state/mubit.dart';
import 'controlled_text_form_field.dart';
import 'recursive_mubit_widget.dart';

class CustomSwitchTile<C extends Mubit<T>, T>
    extends SelectingWidget<C, T, bool> {
  final String title;
  final bool enabled;
  const new({
    super.key,
    required this.title,
    this.enabled = true,
    required super.selector,
    required super.valueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tileHeight,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(title),
          SizedBox(
            width: textFieldWidth,
            child: Transform.scale(
              scale: 0.75,
              child: BlocSelector<C, T, bool>(
                selector: selector,
                builder: (context, state) => Switch(
                  padding: .zero,
                  value: state,
                  onChanged: enabled ? valueChanged : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
