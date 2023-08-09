import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/caregiver/caregiver.dart';

import '../../common/commons.dart';

part 'my_inpatient_state.dart';
part 'my_inpatient_cubit.freezed.dart';

class MyInpatientCubit extends Cubit<MyInpatientState> {
  MyInpatientCubit(this._repository) : super(const MyInpatientState.initial());

  final CaregiverRepository _repository;

  Future<void> fetchMyInpatients() async {
    emit(const MyInpatientState.loading());

    try {
      final inpatients = await _repository.fetchMyInpatients();
      emit(MyInpatientState.loaded(inpatients));
    } on ApiException catch (exception) {
      emit(MyInpatientState.error('message', 'reason'));
    }
  }
}