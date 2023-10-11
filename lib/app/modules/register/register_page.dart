import 'package:flutter/material.dart';
import 'package:todolist/app/core/ui/base_state/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/app/core/ui/helpers/size_extensions.dart';
import 'package:todolist/app/core/ui/widgets/logo.dart';
import 'package:todolist/app/core/ui/widgets/todo_list_form_field.dart';
import 'package:todolist/app/modules/register/register_controller.dart';
import 'package:todolist/app/modules/register/register_state.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            register: () => showLoader(),
            error: () {
              hideLoader();
              showError('Erro ao registrar usuário');
            },
            success: () {
              hideLoader();
              showSuccess('Cadastro realizado com sucesso');
              Navigator.pop(context);
            },
          );
        },
        child: Scaffold(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TodoListFormField(
                        label: 'E-mail',
                        controller: _emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Email obrigatório'),
                          Validatorless.email('Email inválido'),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      TodoListFormField(
                        controller: _passwordEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha obrigatória'),
                          Validatorless.min(
                              6, 'Senha deve conter pelo menos 6 caracteres')
                        ]),
                        label: 'Senha',
                        obscureText: !_isPasswordVisible,
                        icon: _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onPressed: _togglePasswordVisibility,
                      ),
                      const SizedBox(height: 20),
                      TodoListFormField(
                        label: 'Confirmar Senha',
                        validator: Validatorless.multiple([
                          Validatorless.required('Confirmar senha obrigatório'),
                          Validatorless.compare(
                              _passwordEC, 'Senhas diferentes'),
                        ]),
                        obscureText: !_isPasswordVisible,
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
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                            ),
                          ),
                          onPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;
                            if (valid) {
                              controller.register(
                                  _emailEC.text, _passwordEC.text);
                            }
                          },
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
        ));
  }
}
