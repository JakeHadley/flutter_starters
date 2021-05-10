import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Fired when the Login button is pressed on the login page
class LoginInWithEmailButtonPressed extends LoginEvent {
  final String email;
  final String password;

  /// Fired when the Login button is pressed on the login page
  LoginInWithEmailButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
