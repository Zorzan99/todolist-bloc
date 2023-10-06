import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/app/repositories/register/register_repository.dart';
import 'package:todolist/app/services/register/register_service.dart';

class RegisterServiceImpl implements RegisterService {
  final RegisterRepository _registerRepository;
  RegisterServiceImpl({required RegisterRepository registerRepository})
      : _registerRepository = registerRepository;
  @override
  Future<User?> register(String email, String password) =>
      _registerRepository.register(email, password);
}
