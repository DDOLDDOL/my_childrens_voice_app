part of 'sent_message_cubit.dart';

@freezed
class SentMessageState with _$SentMessageState {
  const factory SentMessageState.initial() = _Initial;
  const factory SentMessageState.loading() = _Loading;
  const factory SentMessageState.loaded(List<String> messages) = _Loaded;
  const factory SentMessageState.error(String message, String reason) = _Error;
}