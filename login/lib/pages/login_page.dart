import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/utils.dart' show showError;
import '../blocs/blocs.dart';
import '../services/services.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final authService = RepositoryProvider.of<AuthenticationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationNotAuthenticated) {
            return Container(
              alignment: Alignment.center,
              child: BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(authBloc, authService),
                child: _SignInForm(),
              ),
            );
          } else if (state is AuthenticationFailure) {
            return Center(child: Text(state.message));
          } else {
            //AuthenticationLoading state
            return Center(child: CircularProgressIndicator(strokeWidth: 2));
          }
        },
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);

    void _onLoginButtonPressed() {
      _loginBloc.add(LoginInWithEmailButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }

    void _onNavigateToCreateAccountButtonPressed() {
      _authBloc.add(CreateAccount());
    }

    Widget _buildLoginForm(LoginState state) {
      return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email Address',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: state is LoginLoading ? null : _onLoginButtonPressed,
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: _onNavigateToCreateAccountButtonPressed,
                      child: Text('Create Account'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showError(state.error, context);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            //LoginInitial state
            return _buildLoginForm(state);
          }
        },
      ),
    );
  }
}
