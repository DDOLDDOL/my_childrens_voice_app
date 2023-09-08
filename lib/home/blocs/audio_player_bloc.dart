import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/home/repository/repository.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';
part 'audio_player_bloc.freezed.dart';

class AudioPlayerBLoc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBLoc(this._repository) : super(const AudioPlayerState.stopped()) {
    _repository.watchPlayerState.listen((state) {
      if (state == PlayerState.completed) {
        add(const AudioPlayerEvent.stopRequested());
      }
    });

    on(_play);
    on(_stop);
    on(_pause);
  }

  final AudioPlayerRepository _repository;

  Future<void> _play(
    _PlayRequested event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _repository.playAudio(event.directoryUri, event.fileName);
  }

  Future<void> _stop(
    _StopRequested event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _repository.stopAudio();
  }

  Future<void> _pause(
    _PauseRequested event,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _repository.pauseAudio();
  }

  @override
  Future<void> close() async {
    await _repository.disposeAudioPlayer();
    await super.close();
  }
}
