import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_api_laravel/blocs/Auth_bloc.dart';
import 'package:frontend_api_laravel/event/auth_event.dart';
import 'package:frontend_api_laravel/repository/auth_repository.dart';
import 'package:frontend_api_laravel/state/auth_state.dart';

class HomePage extends StatefulWidget {
  final AuthBloc authBloc;

  const HomePage({Key key, this.authBloc}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: BlocBuilder(
          bloc: _authBloc,
          builder: (context, state) {
            if (state is AuthHasToken) {
              _authBloc.add(GetDataWithToken(state.token));
              return Container();
            }
            if (state is AuthData) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Nama : " + state.name,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Email : " + state.email,
                      style: TextStyle(fontSize: 18),
                    ),
                    RaisedButton(
                      onPressed: () {
                        _authBloc.add(LoggedOut());
                      },
                      child: Text("Logout"),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
