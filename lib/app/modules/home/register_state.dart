import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

@match
enum RegisterStateStatus { inital, login, success, loginError, error }

class RegisterState extends Equatable {
  final RegisterStateStatus status;
  final String? errorMessage;
  const RegisterState({
    required this.status,
    this.errorMessage,
  });
  const RegisterState.inital()
      : status = RegisterStateStatus.inital,
        errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  RegisterState copyWith({
    RegisterStateStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
