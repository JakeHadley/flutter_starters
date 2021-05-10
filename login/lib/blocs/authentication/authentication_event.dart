import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

/// Fired just after the app is launched
class AppLoaded extends AuthenticationEvent {
  /// Fired just after the app is launched
  AppLoaded();
}

/// Fired when create account button is pressed
class CreateAccount extends AuthenticationEvent {
  /// Fired when create account button is pressed
  CreateAccount();
}

/// Fired when a user has successfully logged in
class UserLoggedIn extends AuthenticationEvent {
  final User user;

  /// Fired when a user has successfully logged in
  UserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
}

/// Fired when the user has logged out
class UserLoggedOut extends AuthenticationEvent {
  /// Fired when the user has logged out
  UserLoggedOut();
}
