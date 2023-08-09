import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final EdgeInsets padding;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: const Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0xFFDDDDDD),
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
