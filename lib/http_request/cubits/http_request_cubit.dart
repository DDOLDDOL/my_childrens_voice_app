import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/api/api.dart';

import '../../common/commons.dart';
import '../repository/repository.dart';

part 'http_request_state.dart';
part 'http_request_cubit.freezed.dart';

class HttpRequestCubit extends Cubit<HttpRequestState> {
  HttpRequestCubit(this._repository) : super(const HttpRequestState.initial());

  final HttpRepository _repository;

  void registerInpatient(Inpatient inpatient) {
    _doRequest(
      () => _repository.registerInpatient(inpatient),
      errorMessage: '환자 등록에 오류가 발생했습니다',
    );
  }

  Future<void> _doRequest(
    Future<void> Function() request, {
    String errorMessage = '요청을 완료할 수 없습니다',
  }) async {
    emit(const HttpRequestState.loading());

    try {
      await request();
      emit(const HttpRequestState.success());
    } on ApiException catch (exception) {
      emit(HttpRequestState.error(errorMessage, 'reason'));
    }
  }
}
