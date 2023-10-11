import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/app/core/ui/base_state/base_state.dart';
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
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
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
            showLoader();
          },
          taskAdded: () {
            hideLoader();
            showSuccess('Tarefa adicionada com sucesso');
            _titleController.clear(); // Limpa o campo de título
            _descriptionController.clear(); // Limpa o campo de descrição
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
                onPressed: () => controller.addTask(
                    _titleController.text, _descriptionController.text),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20),
                  ),
                ),
                child: const Text('Adicionar tarefa'),
              ),
              const SizedBox(height: 16),
              BlocBuilder<HomeController, HomeState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.description),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
