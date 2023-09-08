import 'dart:async';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecorderRepository {
  RecorderRepository(this._recorder);

  final FlutterSoundRecorder _recorder;

  Future<void> openRecorder() => _recorder.openRecorder();

  Future<void> closeRecorder() => _recorder.closeRecorder();

  /// 녹음이 끝나면 앱 cache에 자동으로 저장합니다
  /// [getApplicationCacheDirectory] 메서드로 디렉의 uri를 확인할 수 있습니다
  Future<void> startRecording(String toFile) async {
    if (!_recorder.isStopped) return;
    await _recorder.startRecorder(toFile: toFile);
  }

  Future<void> stopRecording() async {
    if (_recorder.isStopped) return;
    await _recorder.stopRecorder();
  }

  Future<void> resumeRecording() async {
    if (!_recorder.isPaused) return;
    await _recorder.resumeRecorder();
  }

  Future<void> pauseRecording() async {
    if (_recorder.isStopped || _recorder.isPaused) return;
    _recorder.pauseRecorder();
  }

  Future<void> checkPermission() async {
    // [microphone] 권한 여부 확인
    if (await Permission.microphone.isGranted) return;

    // [microphone] 권한 없음 => 이전에 거부했을 경우
    if (await Permission.microphone.shouldShowRequestRationale) {
      throw RecordingPermissionException('마이크 사용 권한이 없습니다');
    }

    // [microphone] 권한 없음 => 첫 요청인 경우
    if (await Permission.microphone.request() != PermissionStatus.granted) {
      throw RecordingPermissionException('마이크 사용 권한이 없습니다');
    }
  }
}
