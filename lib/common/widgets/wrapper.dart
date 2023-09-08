import 'package:flutter/material.dart';

// TODO: [BoxDecoration] 리팩토링
class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.decoration,
  }) : super(key: key);

  final EdgeInsets padding;
  final BoxDecoration? decoration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration?.copyWith(
            color: decoration?.color ?? _defaultDecoration.color!,
            shape: decoration?.shape ?? _defaultDecoration.shape,
            borderRadius: decoration?.shape == null
                ? decoration?.borderRadius ?? _defaultDecoration.borderRadius!
                : null,
            boxShadow: decoration?.boxShadow ?? _defaultDecoration.boxShadow!,
          ) ??
          _defaultDecoration,
      child: child,
    );
  }

  BoxDecoration get _defaultDecoration => BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(4, 4),
          ),
        ],
      );
}
