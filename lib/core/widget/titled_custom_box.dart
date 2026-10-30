import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';
import 'custom_box.dart';

class TitledCustomBox extends StatelessWidget {
  final String title;
  final String closedReason;
  final bool open;
  final Widget child;
  final bool transparent;

  const new({
    super.key,
    required this.title,
    required this.closedReason,
    required this.open,
    required this.child,
    this.transparent = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return CustomBox(
      dense: false,
      type: transparent ? .transparent : .normal,
      child: open
          ? Column(
              crossAxisAlignment: .start,
              spacing: 8,
              children: [
                Text(title, style: textTheme.titleMedium),
                child,
              ],
            )
          : Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(title, style: textTheme.titleMedium),
                Text(closedReason),
              ],
            ),
    );
  }
}
