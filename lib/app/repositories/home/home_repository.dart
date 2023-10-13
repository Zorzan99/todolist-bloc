import 'package:todolist/app/models/task_model.dart';

abstract class HomeRepository {
  Future<void> logout();
  Future<TaskModel> addTask(String userId, TaskModel taskModel);
  Future<List<TaskModel>> getFavoritesMovies(String userId);
}
