import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/utils.dart' show showError;
import '../blocs/blocs.dart';
import '../services/services.dart';

class CreateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final authService = RepositoryProvider.of<AuthenticationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationCreation) {
            return Container(
              alignment: Alignment.center,
              child: BlocProvider<AccountCreationBloc>(
                create: (context) => AccountCreationBloc(authBloc, authService),
                child: _CreateAccountForm(),
              ),
            );
          } else {
            //Unknown state
            return Container(child: Text('Bye'));
          }
        },
      ),
    );
  }
}

class _CreateAccountForm extends StatefulWidget {
  @override
  __CreateAccountFormState createState() => __CreateAccountFormState();
}

class __CreateAccountFormState extends State<_CreateAccountForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _accountCreationBloc = BlocProvider.of<AccountCreationBloc>(context);

    void _onCreateAccountButtonPressed() {
      _accountCreationBloc.add(CreateAccountButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      ));
    }

    // Send event to show the login screen
    void _onLoginButtonPressed() {
      _authBloc.add(AppLoaded());
    }

    Widget _buildCreateAccountForm(AccountCreationState state) {
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
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
              ),
            ),
            ElevatedButton(
              child: Text('Create Account'),
              onPressed: state is AccountCreationLoading
                  ? null
                  : _onCreateAccountButtonPressed,
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: _onLoginButtonPressed,
                      child: Text('Login'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return BlocListener<AccountCreationBloc, AccountCreationState>(
      listener: (context, state) {
        if (state is AccountCreationFailure) {
          showError(state.error, context);
        }
      },
      child: BlocBuilder<AccountCreationBloc, AccountCreationState>(
        builder: (context, state) {
          if (state is AccountCreationLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            //AccountCreationInitial state
            return _buildCreateAccountForm(state);
          }
        },
      ),
    );
  }
}
