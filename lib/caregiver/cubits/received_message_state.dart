part of 'received_message_cubit.dart';

@freezed
class ReceivedMessageState with _$ReceivedMessageState {
  const factory ReceivedMessageState.initial() = _Intital;
  const factory ReceivedMessageState.loading() = _Loading;
  const factory ReceivedMessageState.loaded(List<String> message) = _Loaded;
  const factory ReceivedMessageState.error(
    String message,
    String reason,
  ) = _Error;
}
