import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/home/models/models.dart';
import 'package:my_childrens_voice_app/home/repository/repository.dart';

part 'nursing_home_searching_state.dart';
part 'nursing_home_searching_cubit.freezed.dart';

class NursingHomeSearchingCubit extends Cubit<NursingHomeSearchingState> {
  NursingHomeSearchingCubit(this._repository)
      : super(const NursingHomeSearchingState.initial());

  final HomeRepository _repository;

  static NursingHomeSearchingCubit create(BuildContext context) {
    return NursingHomeSearchingCubit(
      RepositoryProvider.of<HomeRepository>(context),
    );
  }

  Future<void> searchNursingHome(String keyword) async {
    emit(const NursingHomeSearchingState.loading());
    try {
      final nursingHomes = await _repository.searchNursingHome(keyword);
      emit(NursingHomeSearchingState.loaded(nursingHomes));
    } on ApiException {
      print('error');
    }
  }
}
