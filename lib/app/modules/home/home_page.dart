import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _todos = [];
  final TextEditingController _textEditingController = TextEditingController();

  void _addTodo() {
    setState(() {
      _todos.add(_textEditingController.text);
      _textEditingController.clear();
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              labelText: 'Nova Tarefa',
              hintText: 'Digite uma nova tarefa',
            ),
          ),
          ElevatedButton(
            onPressed: _addTodo,
            child: const Text('Adicionar Tarefa'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_todos[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeTodo(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
