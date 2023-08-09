import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Icon(
            Icons.notifications,
            size: 24,
            color: Colors.black,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 2,
            ),
          ),
        ],
      ),
    );
  }
}
