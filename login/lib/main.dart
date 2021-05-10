import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';
import 'services/services.dart';
import 'pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationService>(
      create: (context) => FakeAuthenticationService(),
      // Injects the Authentication BLoC
      child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          final authService =
              RepositoryProvider.of<AuthenticationService>(context);
          //Send AppLoaded event while initializing bloc
          return AuthenticationBloc(authService)..add(AppLoaded());
        },
        child: MaterialApp(
          title: 'Authentication Demo',
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationAuthenticated) {
                return HomePage(user: state.user);
              } else if (state is AuthenticationCreation) {
                return CreateAccountPage();
              } else {
                // AuthenticationInitial or AuthenticationNotAuthenticated state
                return LoginPage();
              }
            },
          ),
        ),
      ),
    );
  }
}
