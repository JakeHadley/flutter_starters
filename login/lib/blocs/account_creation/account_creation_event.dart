import 'package:equatable/equatable.dart';

abstract class AccountCreationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Fired when the create account button on the create account page is pressed
/// to create an account
class CreateAccountButtonPressed extends AccountCreationEvent {
  final String email;
  final String password;
  final String confirmPassword;

  /// Fired when the create account button on the create account page is pressed
  /// to create an account
  CreateAccountButtonPressed(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object> get props => [email, password, confirmPassword];
}
