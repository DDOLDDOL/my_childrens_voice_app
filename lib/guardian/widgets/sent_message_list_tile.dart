import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_childrens_voice_app/common/commons.dart';
import 'package:my_childrens_voice_app/guardian/cubits/cubits.dart';

class SentMessageListTile extends StatelessWidget {
  const SentMessageListTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Wrapper(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/message.png', height: 20),
              const SizedBox(width: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 120,
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        BlocBuilder<SentMessageCubit, SentMessageState>(
          builder: (_, __) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              DateFormat('yyyy.MM.dd hh:mm').format(DateTime.now()),
              style: const TextStyle(color: Colors.grey, letterSpacing: -0.5),
            ),
          ),
        ),
      ],
    );
  }
}