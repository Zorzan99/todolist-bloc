import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todolist/app/models/task_model.dart';
import 'package:todolist/app/repositories/home/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<TaskModel> addTask(String userId, TaskModel taskModel) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(taskModel.toMap());

      final TaskModel updatedTask = taskModel.copyWith(
          title: taskModel.title, description: taskModel.description);

      return updatedTask;
    } catch (e, s) {
      log('Erro ao salvar tarefa', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getFavoritesMovies(String userId) async {
    var favoritesMovies = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .get();

    final listFavorites = <TaskModel>[];
    for (var movie in favoritesMovies.docs) {
      listFavorites.add(TaskModel.fromMap(movie.data()));
    }
    return listFavorites;
  }
}
