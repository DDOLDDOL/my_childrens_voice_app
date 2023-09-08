import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/common/commons.dart';
import 'package:my_childrens_voice_app/guardian/cubits/cubits.dart';
import 'package:my_childrens_voice_app/guardian/repository/repository.dart';
import 'package:my_childrens_voice_app/guardian/widgets/widgets.dart';

class SentMessageListView extends StatelessWidget {
  const SentMessageListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SentMessageCubit(context.read<GuardianRepository>())
        ..fetchSentMessage(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<SentMessageCubit, SentMessageState>(
            buildWhen: (previous, current) {
              return current.maybeWhen(
                orElse: () => true,
                loading: () => previous.maybeWhen(
                  orElse: () => false,
                  initial: () => true,
                ),
              );
            },
            builder: (_, state) {
              // TODO: loading view, error view 적용해야 합니다
              return state.maybeWhen(
                orElse: SizedBox.shrink,
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (messages) {
                  return messages.isEmpty
                      ? const _EmptyView()
                      : ListView.separated(
                          padding: const EdgeInsets.all(20).copyWith(top: 8),
                          itemCount: messages.length,
                          itemBuilder: (_, index) {
                            return SentMessageListTile(
                              message: messages[index],
                            );
                          },
                          separatorBuilder: (_, __) {
                            return const SizedBox(height: 16);
                          },
                        );
                },
              );
            },
          ),
        ),
        BlocBuilder<SentMessageCubit, SentMessageState>(
          builder: (_, state) => state.maybeWhen(
            orElse: () => MessageInputForm(
              onSubmit: (message) {
                // TODO: 메시지 보내기
              },
            ),
            initial: SizedBox.shrink,
            error: (_, __) => const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorView(
      icon: Image.asset('assets/images/no-message.png', height: 60),
      message: '보낸 메시지가 없습니다',
      reason: '메시지를 보내보세요!',
    );
  }
}
