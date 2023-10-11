import 'package:todolist/app/models/task_model.dart';
import 'package:todolist/app/repositories/home/home_repository.dart';
import 'package:todolist/app/services/home/home_service.dart';

class HomeServiceImpl implements HomeService {
  final HomeRepository _homeRepository;
  HomeServiceImpl({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;
  @override
  Future<void> logout() => _homeRepository.logout();

  @override
  TaskModel? addTask(String title, String description) =>
      _homeRepository.addTask(title, description);
}
