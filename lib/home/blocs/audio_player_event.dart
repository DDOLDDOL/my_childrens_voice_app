part of 'audio_player_bloc.dart';

@freezed
class AudioPlayerEvent with _$AudioPlayerEvent {
  const factory AudioPlayerEvent.playRequested(
    String directoryUri,
    String fileName,
  ) = _PlayRequested;
  const factory AudioPlayerEvent.stopRequested() = _StopRequested;
  const factory AudioPlayerEvent.resumeRequested() = _ResumeRequested;
  const factory AudioPlayerEvent.pauseRequested() = _PauseRequested;
}
