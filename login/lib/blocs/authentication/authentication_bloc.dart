import 'package:bloc/bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import '../../services/services.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(AuthenticationService authenticationService)
      : _authenticationService = authenticationService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    } else if (event is UserLoggedIn) {
      yield AuthenticationAuthenticated(user: event.user);
    } else if (event is UserLoggedOut) {
      await _authenticationService.signOut();
      yield AuthenticationNotAuthenticated();
    } else if (event is CreateAccount) {
      yield AuthenticationCreation();
    }
  }

  //When App is loaded, set AuthenticationLoading to show a spinner
  //Check if user is logged in, if so, send AuthenticationAuthenticated with the
  //current user to show the home page
  //Otherwise, set to AuthenticationNotAuthenticated to show the login page
  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      final currentUser = _authenticationService.getCurrentUser();

      if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      print(e);
      yield AuthenticationFailure(message: 'An unknown error occurred');
    }
  }
}
