import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:todolist/app/core/ui/base_state/base_state.dart';
import 'package:todolist/app/core/ui/widgets/logo.dart';
import 'package:todolist/app/core/ui/widgets/todo_list_form_field.dart';
import 'package:todolist/app/modules/login/login_controller.dart';
import 'package:todolist/app/modules/login/login_state.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseState<LoginPage, LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          login: () => showLoader(),
          loginError: () {
            hideLoader();
            showError('Login ou senhha inválidos');
          },
          error: () {
            hideLoader();
            showError('Erro ao realizar login');
          },
          success: () {
            hideLoader();
            showSuccess('Login Efetuado com sucesso');
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth,
                  ),
                  child: IntrinsicHeight(
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          const Logo(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TodoListFormField(
                                    label: 'E-mail',
                                    controller: _emailEC,
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'E-mail obrigatório'),
                                      Validatorless.email('E-mail inválido'),
                                    ]),
                                  ),
                                  const SizedBox(height: 20),
                                  TodoListFormField(
                                    controller: _passwordEC,

                                    label: 'Senha',
                                    validator: Validatorless.required(
                                        'Senha obrigatória'),
                                    obscureText: !_isPasswordVisible,
                                    icon: _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    onPressed:
                                        _togglePasswordVisibility, // Chama o método aqui
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Esqueceu sua senha?',
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          final valid = _formKey.currentState
                                                  ?.validate() ??
                                              false;
                                          if (valid) {
                                            controller.loginFirebase(
                                                _emailEC.text,
                                                _passwordEC.text);
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text('Login'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F3F7),
                                border: Border(
                                  top: BorderSide(
                                    width: 2,
                                    color: Colors.grey.withAlpha(30),
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  SignInButton(
                                    Buttons.Google,
                                    text: 'Continuar com o Google',
                                    padding: const EdgeInsets.all(15),
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    onPressed: () {
                                      controller.login();
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Não possui conta?'),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/register');
                                        },
                                        child: const Text(
                                          'Cadastre-se',
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
