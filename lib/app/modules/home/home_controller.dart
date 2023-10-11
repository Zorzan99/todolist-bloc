import 'package:bloc/bloc.dart';
import 'package:todolist/app/models/task_model.dart';
import 'package:todolist/app/modules/home/home_state.dart';
import 'package:todolist/app/repositories/home/home_repository.dart';

class HomeController extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  HomeController(this._homeRepository) : super(const HomeState.inital());

  Future<void> logout() async {
    try {
      emit(state.copyWith(status: HomeStatus.logout));
      await _homeRepository.logout();
    } on Exception catch (e) {
      emit(
          state.copyWith(status: HomeStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> addTask(String title, String description) async {
    emit(state.copyWith(status: HomeStatus.addingTask));
    try {
      final newTask = _homeRepository.addTask(title, description);
      final updatedTasks = List<TaskModel>.from(state.tasks);
      updatedTasks.add(newTask!);
      emit(state.copyWith(status: HomeStatus.taskAdded, tasks: updatedTasks));
    } on Exception catch (e) {
      emit(
        state.copyWith(status: HomeStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
