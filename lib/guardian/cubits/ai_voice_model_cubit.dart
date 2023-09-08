import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/guardian/repository/guardian_respository.dart';

part 'ai_voice_model_state.dart';
part 'ai_voice_model_cubit.freezed.dart';

class AIVoiceModelCubit extends Cubit<AIVoiceModelState> {
  AIVoiceModelCubit(this._repository)
      : super(const AIVoiceModelState.initial());

  final GuardianRepository _repository;

  Future<void> checkVoiceModelExists() async {
    final voiceModelState = await _repository.checkVoiceModelExists();

    if (voiceModelState == 0) return emit(const AIVoiceModelState.noModel());
    if (voiceModelState == 1) return emit(const AIVoiceModelState.training());
    return emit(const AIVoiceModelState.exists());
  }
}
