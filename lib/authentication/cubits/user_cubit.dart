import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/authentication/authentication.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

part 'user_state.dart';

part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._repository) : super(const UserState.initial());

  final AuthenticationRepository _repository;

  Future<void> fetchUser() async {
    emit(const UserState.loading());

    try {
      final user = await _repository.fetchUser();
      emit(UserState.loaded(user));
    } on ApiException catch (exception) {
      emit(UserState.error('message', 'reason'));

      // exception.maybeWhen(
      //   orElse: () {},
      // );
    }
  }
}
