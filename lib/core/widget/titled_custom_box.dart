import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';
import 'custom_box.dart';

class TitledCustomBox extends StatelessWidget {
  final String title;
  final String closedReason;
  final bool open;
  final Widget child;

  const new({
    super.key,
    required this.title,
    required this.closedReason,
    required this.open,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return CustomBox(
      dense: false,
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
