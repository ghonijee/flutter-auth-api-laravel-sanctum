import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_api_laravel/blocs/Auth_bloc.dart';
import 'package:frontend_api_laravel/event/auth_event.dart';
import 'package:frontend_api_laravel/state/auth_state.dart';

class LoginPage extends StatefulWidget {
  final AuthBloc authBloc;

  const LoginPage({Key key, this.authBloc}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc get _authBloc => widget.authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: LoginForm(
        authBloc: _authBloc,
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final AuthBloc authBloc;

  LoginForm({Key key, this.authBloc}) : super(key: key);

  final TextEditingController emailController =
      TextEditingController(text: "akughoni@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "asdasdasd");

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: authBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Login Page"),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email"),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(labelText: "Password"),
                      ),
                      RaisedButton(
                        onPressed: _login,
                        child: (state is AuthLoading)
                            ? Text("Please wait")
                            : Text("Login"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (state is LoginFailed) ? Text(state.error) : Text(""),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _login() {
    authBloc.add(LoginProcess(
      email: emailController.text,
      password: passwordController.text,
    ));
  }
}
