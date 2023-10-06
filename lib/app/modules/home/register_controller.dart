import 'package:bloc/bloc.dart';
import 'package:todolist/app/modules/home/register_state.dart';
import 'package:todolist/app/repositories/register/register_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final RegisterRepository _registerRepository;
  RegisterController(this._registerRepository)
      : super(const RegisterState.inital());

  Future<void> register(String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStateStatus.login));
      await _registerRepository.register(email, password);
      emit(state.copyWith(status: RegisterStateStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: RegisterStateStatus.error, errorMessage: e.toString()));
    }
  }
}
