import 'package:bloc/bloc.dart';
import 'package:todolist/app/core/auth/auth_service.dart';
import 'package:todolist/app/models/task_model.dart';
import 'package:todolist/app/modules/home/home_state.dart';
import 'package:todolist/app/repositories/home/home_repository.dart';

class HomeController extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  final AuthService _authService;
  HomeController(this._homeRepository, this._authService)
      : super(const HomeState.inital());

  Future<void> logout() async {
    try {
      emit(state.copyWith(status: HomeStatus.logout));
      await _homeRepository.logout();
    } on Exception catch (e) {
      emit(
          state.copyWith(status: HomeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addTask(String userId, TaskModel taskModel) async {
    try {
      emit(state.copyWith(status: HomeStatus.addingTask));
      final newTask = await _homeRepository.addTask(userId, taskModel);

      final updatedTasks = List<TaskModel>.from(state.tasks);
      updatedTasks.add(newTask);
      emit(state.copyWith(status: HomeStatus.taskAdded, tasks: updatedTasks));
    } on Exception catch (e) {
      emit(
        state.copyWith(status: HomeStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> favoriteMovie(TaskModel taskModel) async {
    final user = _authService.user;
    if (user != null) {
      var task = taskModel.copyWith(
          description: taskModel.description, title: taskModel.title);
      await _homeRepository.addTask(user.uid, task);
    }
  }

  Future<Map<String, TaskModel>> getFavorites() async {
    final user = _authService.user;
    if (user != null) {
      final favorites = await _homeRepository.getFavoritesMovies(user.uid);
      return <String, TaskModel>{
        for (var fav in favorites) fav.title: fav,
      };
    }
    return {};
  }

  Future<void> fetchTasks(String userId) async {
    try {
      final tasks = await _homeRepository.getFavoritesMovies(userId);

      emit(state.copyWith(status: HomeStatus.loaded, tasks: tasks));
    } catch (e) {
      emit(state.copyWith(
          status: HomeStatus.error, errorMessage: 'Erro ao buscar tarefas'));
    }
  }
}
