import 'package:bloc/bloc.dart';
import 'package:todolist/app/modules/login/login_state.dart';
import 'package:todolist/app/repositories/login/login_repository.dart';

class LoginController extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  LoginController(this._loginRepository) : super(const LoginState.inital());

  Future<void> login() async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      await _loginRepository.login();
      emit(state.copyWith(status: LoginStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: LoginStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loginFirebase(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      await _loginRepository.loginFirebase(email, password);
      emit(state.copyWith(status: LoginStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: LoginStatus.error, errorMessage: e.toString()));
    }
  }
}
