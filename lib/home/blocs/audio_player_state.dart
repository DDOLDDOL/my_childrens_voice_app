part of 'audio_player_bloc.dart';

@freezed
class AudioPlayerState with _$AudioPlayerState {
  const factory AudioPlayerState.stopped() = _Stopped;
  const factory AudioPlayerState.onPlaying() =_OnPlaying;
  const factory AudioPlayerState.paused() = _Paused;
}