import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
part 'register_state.g.dart';

@match
enum RegisterStateStatus { inital, register, success, error }

class RegisterState extends Equatable {
  final RegisterStateStatus status;
  const RegisterState({
    required this.status,
  });
  const RegisterState.inital() : status = RegisterStateStatus.inital;

  RegisterState copyWith({
    RegisterStateStatus? status,
  }) {
    return RegisterState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
