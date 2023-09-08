part of 'recorder_bloc.dart';

@freezed
class RecorderEvent with _$RecorderEvent {
  const factory RecorderEvent.permissionCheckRequested() =
      _PermissionCheckRequested;
  const factory RecorderEvent.recordRequested(String toFile) = _RecordRequested;
  // const factory RecorderEvent.resumeRequested() = _ResumeRequested;
  // const factory RecorderEvent.pauseRequested() = _PauseRequested;
  const factory RecorderEvent.stopRequested() = _StopRequested;
}
