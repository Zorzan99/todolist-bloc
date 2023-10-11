import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist/app/models/task_model.dart';
import 'package:todolist/app/repositories/home/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final List<TaskModel> _tasks = [];
  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  TaskModel? addTask(String title, String description) {
    if (title.isNotEmpty) {
      final newTask = TaskModel(title: title, description: description);
      _tasks.add(newTask);
      return newTask;
    }
    return null;
  }
}
