part of 'recorder_bloc.dart';

@freezed
class RecorderState with _$RecorderState {
  // initial state & recorder is closed
  const factory RecorderState.checkingPermission() = _CheckingPermission;
  const factory RecorderState.permissionDenied(
    String message,
  ) = _PermissionDenied; // microphone permission denied & recorder is closed
  const factory RecorderState.onReady() = _OnReady; // recorder is opened
  // recorder is started / resumed
  const factory RecorderState.onRecording() = _OnRecording;
  // const factory RecorderState.paused() = _Paused; // recorder is paused
}
