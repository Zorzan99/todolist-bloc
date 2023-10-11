// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:todolist/app/models/task_model.dart';
part 'home_state.g.dart';

@match
enum HomeStatus {
  inital,
  loading,
  loaded,
  empty,
  error,
  addingTask,
  taskAdded,
  taskUpdated,
  taskDeleted,
  editingTask,
  logout,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final String? errorMessage;
  final List<TaskModel> tasks;

  const HomeState({
    required this.status,
    required this.errorMessage,
    required this.tasks,
  });

  const HomeState.inital()
      : status = HomeStatus.inital,
        errorMessage = null,
        tasks = const [];

  @override
  List<Object?> get props => [status, errorMessage, tasks];
  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<TaskModel>? tasks,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      tasks: tasks ?? this.tasks,
    );
  }
}
