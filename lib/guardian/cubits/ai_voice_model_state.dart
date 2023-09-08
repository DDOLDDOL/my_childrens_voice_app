part of 'ai_voice_model_cubit.dart';

@freezed
class AIVoiceModelState with _$AIVoiceModelState {
  const factory AIVoiceModelState.initial() = _Initial;
  const factory AIVoiceModelState.checking() = _Checking;
  const factory AIVoiceModelState.noModel() = _NoModel;
  const factory AIVoiceModelState.training() = _Training;
  const factory AIVoiceModelState.exists() = _Exists;
}