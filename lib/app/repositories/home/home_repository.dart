import 'package:todolist/app/models/task_model.dart';

abstract class HomeRepository {
  Future<void> logout();
  TaskModel? addTask(String title, String description);
}
