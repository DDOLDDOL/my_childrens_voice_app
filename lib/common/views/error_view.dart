import 'package:flutter/material.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
    required this.message,
    required this.reason,
    this.icon,
    this.onRefresh,
  }) : super(key: key);

  final String message;
  final String reason;
  final Widget? icon;
  final void Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon!,
          const SizedBox(height: 20),
          Text(message, style: TextStyles.title.copyWith(fontSize: 20)),
          const SizedBox(height: 8),
          Text(reason, style: TextStyles.subtitle.copyWith(fontSize: 14)),
          const SizedBox(height: 28),
          if (onRefresh != null) _RefreshButton(onPressed: onRefresh!),
        ],
      ),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade400,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: const Text(
        '다시 시도',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }
}
