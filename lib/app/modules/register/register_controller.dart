import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:todolist/app/modules/register/register_state.dart';
import 'package:todolist/app/repositories/register/register_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final RegisterRepository _registerRepository;
  RegisterController(this._registerRepository)
      : super(const RegisterState.inital());

  Future<void> register(String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStateStatus.register));
      await _registerRepository.register(email, password);
      emit(state.copyWith(status: RegisterStateStatus.success));
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWith(
        status: RegisterStateStatus.error,
      ));
    }
  }
}
