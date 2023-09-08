import 'package:flutter/material.dart';

import '../../common/commons.dart';

class RecordedFilePlayer extends StatelessWidget {
  const RecordedFilePlayer({
    Key? key,
    required this.onPlay,
    required this.onStop,
    required this.onNext,
    required this.onClose,
  }) : super(key: key);

  final void Function() onPlay;
  final void Function() onStop;
  final void Function() onNext;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '녹음이 완료되었습니다',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              InkWell(
                onTap: onClose,
                child: const Icon(Icons.close, size: 25),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '올바르게 녹음되었는지 확인 후 다음 문장으로 넘어가주세요',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _PlayerButton(
                onTap: onPlay,
                icon: Icons.play_arrow,
              ),
              const SizedBox(width: 16),
              _PlayerButton(
                onTap: onStop,
                icon: Icons.stop,
              ),
              const Spacer(),
              _NextButton(onTap: onNext),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlayerButton extends StatelessWidget {
  const _PlayerButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Wrapper(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: Colors.red.shade300),
        ),
        child: Center(child: Icon(icon, size: 24, color: Colors.red.shade300)),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Wrapper(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.red.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '다음',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.red.shade400,
          ),
        ),
      ),
    );
  }
}
