import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/common/commons.dart';
import 'package:my_childrens_voice_app/guardian/repository/repository.dart';
import 'package:my_childrens_voice_app/guardian/cubits/cubits.dart';

import '../views/views.dart';
import 'voice_recording_screen.dart';

class MessageSendingScreen extends StatelessWidget {
  const MessageSendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AIVoiceModelCubit(context.read<GuardianRepository>())
        ..checkVoiceModelExists(),
      child: const _MessageSendingView(),
    );
  }
}

class _MessageSendingView extends StatelessWidget {
  const _MessageSendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: Text('메시지 보내기')),
      body: BlocBuilder<AIVoiceModelCubit, AIVoiceModelState>(
        builder: (_, state) {
          return state.maybeWhen(
            orElse: SizedBox.shrink,
            checking: () => const Center(child: CircularProgressIndicator()),
            noModel: _AIModelEmptyView.new,
            training: _AIModelTrainingView.new,
            exists: SentMessageListView.new,
          );
        },
      ),
    );
  }
}

class _AIModelEmptyView extends StatelessWidget {
  const _AIModelEmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorView(
      icon: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.shade50,
          border: Border.all(width: 1, color: Colors.red.shade100),
        ),
        child: Image.asset('assets/images/no-voice.png', height: 60),
      ),
      message: '나의 보이스 AI 모델이 없습니다',
      reason: '제시된 문장들을 본인의 음성으로 녹음하고\n보이스 AI를 학습시킬 수 있습니다',
      refreshButtonText: 'AI 학습 문장 녹음하기',
      onRefresh: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const VoiceRecordingScreen()),
        );
      },
    );
  }
}

class _AIModelTrainingView extends StatelessWidget {
  const _AIModelTrainingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorView(
      icon: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightBlue.shade50,
            ),
            child: Image.asset('assets/images/training.png', height: 60),
          ),
          SizedBox(
            width: 116,
            height: 116,
            child: CircularProgressIndicator(color: Colors.lightBlue.shade100),
          ),
        ],
      ),
      message: '보이스 AI 모델을 훈련중입니다',
      reason: '훈련이 끝나면 알려드릴게요!\n훈련이 끝나면 메시지를 보내실 수 있습니다',
    );
  }
}