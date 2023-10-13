import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/app/core/ui/base_state/base_state.dart';
import 'package:todolist/app/models/task_model.dart';
import 'package:todolist/app/modules/home/home_controller.dart';
import 'package:todolist/app/modules/home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    controller.fetchTasks(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      listener: (context, state) {
        print(state);
        state.status.match(
          inital: () {},
          loading: () {
            showLoader();
          },
          loaded: () {},
          empty: () {},
          error: () {
            hideLoader();
            showError('Erro ao adicionar tarefa');
          },
          addingTask: () {
            _titleController.clear();
            _descriptionController.clear();
          },
          taskAdded: () {
            showLoader();
            showSuccess('Tarefa adicionada com sucesso');
            hideLoader();
          },
          taskUpdated: () {},
          taskDeleted: () {},
          editingTask: () {},
          logout: () {
            hideLoader();
            showSuccess('Logout realizado com sucesso');
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        );
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user!.displayName ?? ''),
                accountEmail: Text(user!.email ?? ''),
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: user?.photoURL != null
                        ? Image.network(
                            user!.photoURL.toString(),
                          )
                        : Image.asset('assets/images/icon.png'),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Sair'),
                onTap: () {
                  controller.logout();
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Adicionar Tarefa'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título da Tarefa',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição da Tarefa',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  String userId = FirebaseAuth.instance.currentUser!.uid;

                  if (_titleController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty) {
                    final TaskModel taskModel = TaskModel(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );
                    controller.addTask(userId, taskModel);
                  }
                },
                child: const Text('Adicionar Tarefa'),
              ),
              const SizedBox(height: 16),
              BlocSelector<HomeController, HomeState, List<TaskModel>>(
                builder: (context, tasks) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            onTap: () {},
                            title: Text(task.title),
                            subtitle: Text(task.description),
                          ),
                        );
                      },
                    ),
                  );
                },
                selector: (state) {
                  return state.tasks;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
