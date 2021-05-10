import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

/// State for when app boots up, before AppLoaded event has fired
class AuthenticationInitial extends AuthenticationState {
  /// State for when app boots up, before AppLoaded event has fired
  AuthenticationInitial();
}

/// State for when app boots up, after AppLoaded event has fired, and is checking
/// to see if user is authenticated or not
class AuthenticationLoading extends AuthenticationState {
  /// State for when app boots up, after AppLoaded event has fired, and is checking
  /// to see if user is authenticated or not
  AuthenticationLoading();
}

/// State for when AppLoaded event has fired, and the authentication service
/// cannot authenticate the user immediately,
/// or when UserLoggedOut event fires and a user signs out.
class AuthenticationNotAuthenticated extends AuthenticationState {
  /// State for when AppLoaded event has fired, and the authentication service
  /// cannot authenticate the user immediately,
  /// or when a user signs out.
  AuthenticationNotAuthenticated();
}

/// State for when CreateAccount event has fired, and the app switches from the
/// login page to the create account page
class AuthenticationCreation extends AuthenticationState {
  /// State for when CreateAccount event has fired, and the app switches from the
  /// login page to the create account page
  AuthenticationCreation();
}

/// State that holds a user object model, for when the UserLoggedIn event
/// fires and the user is authenticated
class AuthenticationAuthenticated extends AuthenticationState {
  final User user;

  /// State that holds a user object model, for when the UserLoggedIn event
  /// fires and the user is authenticated
  AuthenticationAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

/// State that holds a message string for when an unknown error occurs when an
/// AppLoaded event is fired
class AuthenticationFailure extends AuthenticationState {
  final String message;

  /// State that holds a message string for when an unknown error occurs when an
  /// AppLoaded event is fired
  AuthenticationFailure({required this.message});

  @override
  List<Object> get props => [message];
}
