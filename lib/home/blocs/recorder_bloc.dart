import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/home/repository/repository.dart';

part 'recorder_event.dart';
part 'recorder_state.dart';
part 'recorder_bloc.freezed.dart';

class RecorderBloc extends Bloc<RecorderEvent, RecorderState> {
  RecorderBloc(this._repository)
      : super(const RecorderState.checkingPermission()) {
    on(_checkPermission);
    on(_record);
    on(_stop);
    // on(_resume);
    // on(_pause);
  }

  final RecorderRepository _repository;

  Future<void> _checkPermission(
    _PermissionCheckRequested event,
    Emitter<RecorderState> emit,
  ) async {
    try {
      await _repository.checkPermission();
      // TODO: [openRecorder]에서의 예외처리를 위해 분리해아 합니다
      await _repository.openRecorder();

      emit(const RecorderState.onReady());
    } on RecordingPermissionException catch (exception) {
      emit(RecorderState.permissionDenied(exception.message));
    }
  }

  Future<void> _record(
    _RecordRequested event,
    Emitter<RecorderState> emit,
  ) async {
    _repository.startRecording(event.toFile);
    emit(const RecorderState.onRecording());
  }

  Future<void> _stop(
    _StopRequested event,
    Emitter<RecorderState> emit,
  ) async {
    _repository.stopRecording();
    emit(const RecorderState.onReady());
  }

  // Future<void> _resume(
  //   _ResumeRequested event,
  //   Emitter<RecorderState> emit,
  // ) async {
  //   _repository.resumeRecording();
  //   emit(const RecorderState.onRecording());
  // }
  //
  // Future<void> _pause(
  //   _PauseRequested event,
  //   Emitter<RecorderState> emit,
  // ) async {
  //   _repository.pauseRecording();
  //   emit(const RecorderState.paused());
  // }

  @override
  Future<void> close() async {
    _repository.closeRecorder();
    await super.close();
  }
}
