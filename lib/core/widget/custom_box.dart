import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../constants.dart';
import '../extensions/context_extension.dart';

enum CustomBoxType { normal, accent, selected }

class CustomBox extends StatelessWidget {
  final Widget child;
  final CustomBoxType type;
  final bool dense;
  const CustomBox({
    super.key,
    required this.child,
    this.type = .normal,
    this.dense = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return GestureDetector(
      behavior: .opaque,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        constraints: BoxConstraints(maxWidth: customBoxWidth),
        padding: .symmetric(
          horizontal: dense ? 6 : 16,
          vertical: dense ? 3 : 12,
        ),
        decoration: BoxDecoration(
          color: switch (type) {
            .normal => colorScheme.surfaceContainer,
            .accent => colorScheme.surface,
            .selected => colorScheme.secondaryContainer,
          },
          border: .all(
            color: switch (type) {
              .normal => colorScheme.surfaceContainer,
              .accent => colorScheme.surface,
              .selected => colorScheme.primary,
            },
          ),
          borderRadius: .circular(8),
        ),
        child: AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          child: child,
        ),
      ),
    );
  }
}
