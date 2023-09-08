import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/caregiver/cubits/cubits.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

import '../repository/repository.dart';
import '../widgets/widgets.dart';

class ReceivedMessageListScreen extends StatelessWidget {
  const ReceivedMessageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceivedMessageCubit(
        context.read<CaregiverRepository>(),
      )..fetchReceivedMessages(),
      child: const _ReceivedMessageListView(),
    );
  }
}

class _ReceivedMessageListView extends StatelessWidget {
  const _ReceivedMessageListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: Text('도착한 메시지')),
      body: ListView(
        padding: const EdgeInsets.all(20).copyWith(top: 8),
        children: ['엄마 지금 버스 안이라 통화하기 어려워. 내려서 바로 전화할게. 사랑해']
            .map(
              (message) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ReceivedMessageListTile(message: message),
              ),
            )
            .toList(),
      ),
    );
  }
}
