import 'package:flutter/material.dart';

import '../constants.dart';
import '../extensions/context_extension.dart';

class ControlledTextFormField extends StatefulWidget {
  final void Function(String value) valueChanged;
  final String value;
  final String? hintText;
  final int maxLines;
  final String? title;
  final bool dense;
  const ControlledTextFormField({
    super.key,
    required this.valueChanged,
    this.value = "",
    this.hintText,
    this.maxLines = 1,
    this.title,
    this.dense = true,
  });

  @override
  State<ControlledTextFormField> createState() =>
      _ControlledTextFormFieldState();
}

class _ControlledTextFormFieldState extends State<ControlledTextFormField> {
  late final TextEditingController controller = TextEditingController(
    text: widget.value,
  );
  @override
  void didUpdateWidget(covariant ControlledTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != controller.text) controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.bodyMedium!;
    final field = TextFormField(
      textAlign: .center,
      controller: controller,
      maxLines: widget.maxLines,
      onChanged: widget.valueChanged,
      style: TextTheme.of(context).bodyMedium,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textStyle.copyWith(color: textStyle.color!.withAlpha(128)),
        contentPadding: widget.dense
            ? .symmetric(horizontal: 4, vertical: 6)
            : .symmetric(horizontal: 6, vertical: 10),
        isDense: true,
        border: OutlineInputBorder(),
      ),
    );
    if (widget.title == null) return field;
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Text(widget.title!),
        SizedBox(width: textFieldWidth, child: field),
      ],
    );
  }
}
