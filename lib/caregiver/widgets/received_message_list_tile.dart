import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/commons.dart';

class ReceivedMessageListTile extends StatelessWidget {
  const ReceivedMessageListTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrapper(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 28),
              _PlayerButton(
                onTap: () {},
                icon1: Icons.play_arrow,
                icon2: Icons.stop,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            DateFormat('yyyy.MM.dd hh:mm').format(DateTime.now()),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class _PlayerButton extends StatefulWidget {
  const _PlayerButton({
    Key? key,
    required this.icon1,
    required this.icon2,
    required this.onTap,
  }) : super(key: key);

  final IconData icon1;
  final IconData icon2;
  final void Function() onTap;

  @override
  State<_PlayerButton> createState() => _PlayerButtonState();
}

class _PlayerButtonState extends State<_PlayerButton> {
  late bool isPlaying;

  @override
  void initState() {
    super.initState();
    isPlaying = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => isPlaying = !isPlaying);
        widget.onTap();
      },
      child: Wrapper(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: Colors.red.shade300),
        ),
        child: Center(
          child: Icon(
            isPlaying ? widget.icon2 : widget.icon1,
            size: 24,
            color: Colors.red.shade300,
          ),
        ),
      ),
    );
  }
}

// class _PlayerButton extends StatelessWidget {
//   const _PlayerButton({
//     Key? key,
//     required this.icon,
//     required this.onTap,
//   }) : super(key: key);
//
//   final IconData icon;
//   final void Function() onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Wrapper(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(width: 1, color: Colors.red.shade300),
//         ),
//         child: Center(child: Icon(icon, size: 24, color: Colors.red.shade300)),
//       ),
//     );
//   }
// }
