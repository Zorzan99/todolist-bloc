import 'package:todolist/app/models/task_model.dart';

abstract interface class HomeService {
  Future<void> logout();
  Future<TaskModel> addTask(String userId, TaskModel taskModel);
  Future<List<TaskModel>> getFavoritesMovies(String userId);
}
