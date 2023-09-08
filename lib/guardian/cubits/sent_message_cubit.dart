import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/guardian/repository/guardian_respository.dart';

part 'sent_message_state.dart';
part 'sent_message_cubit.freezed.dart';

class SentMessageCubit extends Cubit<SentMessageState> {
  SentMessageCubit(this._repository) : super(const SentMessageState.initial());

  final GuardianRepository _repository;

  Future<void> fetchSentMessage() async {
    emit(const SentMessageState.loading());

    try {
      final messages = await _repository.fetchSentMessages();
      emit(SentMessageState.loaded(messages));
    } on Exception catch (error) {
      emit(
        SentMessageState.error(
          '보낸 메시지 불러오기 오류',
          error.toString().split('Exception: ').last,
        ),
      );
    }
  }
}
