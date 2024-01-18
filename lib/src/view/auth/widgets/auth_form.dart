// ignore_for_file: sort_child_properties_last, constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/model/auth.dart';
import 'package:todo_list/src/view/default_widgets/glass_card.dart';

import '../../../utils/auth_exception.dart';

enum AuthMode { SingUp, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  AuthMode _authMode = AuthMode.Login;

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.SingUp;

  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.SingUp;
        _controller?.forward();
      } else {
        _authMode = AuthMode.Login;
        _controller?.reverse();
      }
    });
  }

  final Map<String, String> _authData = {
    'nomeUsuario': '',
    'senha': '',
    'email': '',
  };

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text("Ocorreu um erro"),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Fechar"),
              ),
            ],
          )),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.signIn(
          _authData['nomeUsuario']!,
          _authData['senha']!,
          _authData['email']!,
        );
      } else {
        await auth.signUp(
          _authData['nomeUsuario']!,
          _authData['senha']!,
          _authData['email']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      print(error);
      _showErrorDialog(error.toString());
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GlassCard(
      backgroundColor: Colors.white,
      heigth: _isLogin() ? 320 : 440,
      width: deviceSize.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome do Usuário'),
                autofocus: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onSaved: (username) =>
                    _authData['nomeUsuario'] = username ?? '',
                validator: (_nomeUser) {
                  final username = _nomeUser ?? '';
                  if (username.trim().isEmpty) {
                    return "Informe um usuário válido";
                  } else if (username.length > 16 || username.length < 3) {
                    return "Informe um nome entre 3 a 16 letras";
                  }
                  return null;
                },
              ),
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isLogin() ? 0 : 40,
                  maxHeight: _isLogin() ? 0 : 60,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                      ),
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onSaved: (email) => _authData['email'] = email ?? '',
                      validator: (_email) {
                        final email = _email ?? '';
                        if ((email.trim().isEmpty || !email.contains('@')) &&
                            _isSignup()) {
                          return "Informe um email válido";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                controller: _passwordController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onSaved: (password) => _authData['senha'] = password ?? '',
                obscureText: true,
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.isEmpty) {
                    return "Informe uma senha válida";
                  } else if (password.length < 6 && _isSignup()) {
                    return "Informe uma senha maior que 6 letras";
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  if (_isLogin()) {
                    _focusNode.requestFocus();
                  }
                },
              ),
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isLogin() ? 0 : 40,
                  maxHeight: _isLogin() ? 0 : 60,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Confirmar Senha',
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        validator: _isLogin()
                            ? null
                            : (_password) {
                                final password = _password ?? '';
                                if (password != _passwordController.text) {
                                  return "Senhas não conferem!";
                                }
                                return null;
                              }),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : TextButton(
                      onPressed: _submit,
                      focusNode: _focusNode,
                      child: Text(
                        _isLogin() ? 'ENTRAR' : 'REGISTRAR',
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      )),
                    ),
              const Spacer(),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _isLogin() ? "DESEJA REGISTRAR?" : "JÁ POSSUÍ CONTA?",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
