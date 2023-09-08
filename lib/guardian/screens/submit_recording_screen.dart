import 'package:flutter/material.dart';

import '../../common/commons.dart';

class SubmitRecordingScreen extends StatelessWidget {
  const SubmitRecordingScreen({
    Key? key,
    required this.sentences,
  }) : super(key: key);

  final List<String> sentences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: Text('음성 파일 전송')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: sentences.length,
              itemBuilder: (_, index) => _SentenceListTile(
                sentence: sentences[index],
              ),
              separatorBuilder: (_, __) => Container(
                color: Colors.grey.shade300,
                height: 8,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20).copyWith(top: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
              ],
            ),
            child: SubmitButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('보이스 AI 모델 생성 요청이 완료되었습니다'),
                  ),
                );
              },
              enabledColor: Colors.red,
              child: const Text('녹음 파일 전송하기'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SentenceListTile extends StatelessWidget {
  const _SentenceListTile({
    Key? key,
    required this.sentence,
  }) : super(key: key);

  final String sentence;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20).copyWith(top: 16, bottom: 16),
      // color: index.isEven ? Colors.teal.shade50 : Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(sentence),
            ),
          ),
          _PlayerButton(icon: Icons.play_arrow, onTap: () {}),
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
