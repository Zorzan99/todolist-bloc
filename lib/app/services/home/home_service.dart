import 'package:todolist/app/models/task_model.dart';

abstract interface class HomeService {
  Future<void> logout();
  TaskModel? addTask(String title, String description);
}
