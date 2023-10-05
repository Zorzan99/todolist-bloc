import 'package:flutter/material.dart';
import 'package:todolist/app/core/ui/helpers/size_extensions.dart';
import 'package:todolist/app/core/ui/widgets/logo.dart';
import 'package:todolist/app/core/ui/widgets/todo_list_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lista de tarefas',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const ClipOval(
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: context.percentWidth(.5),
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: Logo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              child: Column(
                children: [
                  const TodoListFormField(label: 'E-mail'),
                  const SizedBox(height: 20),
                  TodoListFormField(
                    label: 'Senha',
                    obscureText: _isPasswordVisible,
                    icon: _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onPressed: _togglePasswordVisibility,
                  ),
                  const SizedBox(height: 20),
                  TodoListFormField(
                    label: 'Confirmar Senha',
                    obscureText: _isPasswordVisible,
                    icon: _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onPressed: _togglePasswordVisibility,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Salvar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
