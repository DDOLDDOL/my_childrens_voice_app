import 'package:audioplayers/audioplayers.dart';

class AudioPlayerRepository {
  AudioPlayerRepository(this._player);

  final AudioPlayer _player;

  Future<void> playAudio(String directoryUri, String fileName) async {
    if (_player.state == PlayerState.disposed) return;
    if (_player.state == PlayerState.playing) return;
    await _player.play(UrlSource('$directoryUri$fileName'));
  }

  Future<void> stopAudio() async {
    if (_player.state == PlayerState.disposed) return;
    if (_player.state == PlayerState.stopped) return;
    await _player.stop();
  }

  Future<void> resumeAudio() async {
    if (_player.state == PlayerState.paused)  await _player.resume();
  }

  Future<void> pauseAudio() async {
    if (_player.state == PlayerState.playing) await _player.pause();
  }

  Future<void> disposeAudioPlayer() => _player.dispose();

  Stream<PlayerState> get watchPlayerState => _player.onPlayerStateChanged;
}
