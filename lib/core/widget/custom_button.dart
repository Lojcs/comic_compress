import 'package:flutter/material.dart';

import '../extensions/context_extension.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final double? iconSize;
  final Axis iconAxis;
  final void Function() onTap;
  final BorderRadius? borderRadius;
  final EdgeInsets padding;
  final TextStyle? textStyle;
  final bool enabled;
  const new({
    super.key,
    required this.text,
    this.icon,
    this.iconSize,
    this.iconAxis = .horizontal,
    required this.onTap,
    this.borderRadius,
    this.padding = const .symmetric(horizontal: 4),
    this.textStyle,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final borderRadius = this.borderRadius ?? .circular(4);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: enabled
            ? colorScheme.secondaryContainer
            : colorScheme.surfaceContainer,
        borderRadius: borderRadius,
      ),
      child: Material(
        borderRadius: borderRadius,
        type: .transparency,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: enabled ? onTap : null,
          child: Padding(
            padding: padding,
            child: Flex(
              direction: iconAxis,
              mainAxisAlignment: .center,
              mainAxisSize: .min,
              spacing: 8,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: context.colorScheme.onSecondaryContainer,
                    size: iconSize,
                  ),
                Text(
                  text,
                  style: (textStyle ?? textTheme.bodyMedium!).copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
