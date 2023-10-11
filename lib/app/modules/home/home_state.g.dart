// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension HomeStatusMatch on HomeStatus {
  T match<T>(
      {required T Function() inital,
      required T Function() loading,
      required T Function() loaded,
      required T Function() empty,
      required T Function() error,
      required T Function() addingTask,
      required T Function() taskAdded,
      required T Function() taskUpdated,
      required T Function() taskDeleted,
      required T Function() editingTask,
      required T Function() logout}) {
    final v = this;
    if (v == HomeStatus.inital) {
      return inital();
    }

    if (v == HomeStatus.loading) {
      return loading();
    }

    if (v == HomeStatus.loaded) {
      return loaded();
    }

    if (v == HomeStatus.empty) {
      return empty();
    }

    if (v == HomeStatus.error) {
      return error();
    }

    if (v == HomeStatus.addingTask) {
      return addingTask();
    }

    if (v == HomeStatus.taskAdded) {
      return taskAdded();
    }

    if (v == HomeStatus.taskUpdated) {
      return taskUpdated();
    }

    if (v == HomeStatus.taskDeleted) {
      return taskDeleted();
    }

    if (v == HomeStatus.editingTask) {
      return editingTask();
    }

    if (v == HomeStatus.logout) {
      return logout();
    }

    throw Exception('HomeStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? inital,
      T Function()? loading,
      T Function()? loaded,
      T Function()? empty,
      T Function()? error,
      T Function()? addingTask,
      T Function()? taskAdded,
      T Function()? taskUpdated,
      T Function()? taskDeleted,
      T Function()? editingTask,
      T Function()? logout}) {
    final v = this;
    if (v == HomeStatus.inital && inital != null) {
      return inital();
    }

    if (v == HomeStatus.loading && loading != null) {
      return loading();
    }

    if (v == HomeStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == HomeStatus.empty && empty != null) {
      return empty();
    }

    if (v == HomeStatus.error && error != null) {
      return error();
    }

    if (v == HomeStatus.addingTask && addingTask != null) {
      return addingTask();
    }

    if (v == HomeStatus.taskAdded && taskAdded != null) {
      return taskAdded();
    }

    if (v == HomeStatus.taskUpdated && taskUpdated != null) {
      return taskUpdated();
    }

    if (v == HomeStatus.taskDeleted && taskDeleted != null) {
      return taskDeleted();
    }

    if (v == HomeStatus.editingTask && editingTask != null) {
      return editingTask();
    }

    if (v == HomeStatus.logout && logout != null) {
      return logout();
    }

    return any();
  }
}
