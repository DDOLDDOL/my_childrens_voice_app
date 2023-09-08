import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  const Star({
    Key? key,
    this.isActive = true,
    this.size = 20,
    this.onTap,
  }) : super(key: key);

  final bool isActive;
  final double size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.star,
        color: isActive ? Colors.yellow.shade600 : Colors.grey.shade300,
        size: size,
      ),
    );
  }
}
