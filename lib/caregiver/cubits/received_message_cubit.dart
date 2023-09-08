import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/caregiver/caregiver.dart';

part 'received_message_state.dart';

part 'received_message_cubit.freezed.dart';

class ReceivedMessageCubit extends Cubit<ReceivedMessageState> {
  ReceivedMessageCubit(this._repository)
      : super(const ReceivedMessageState.initial());

  final CaregiverRepository _repository;

  Future<void> fetchReceivedMessages() async {
    emit(const ReceivedMessageState.loading());

    try {
      final messages = await _repository.fetchReceivedMessages();
      emit(ReceivedMessageState.loaded(messages));
    } on Exception catch (error) {
      emit(
        ReceivedMessageState.error(
          '보낸 메시지 불러오기 오류',
          error.toString().split('Exception: ').last,
        ),
      );
    }
  }
}
