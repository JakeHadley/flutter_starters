import 'package:equatable/equatable.dart';

abstract class AccountCreationState extends Equatable {
  @override
  List<Object> get props => [];
}

/// State for initial rendering of create account page
class AccountCreationInitial extends AccountCreationState {
  /// State for initial rendering of create account page
  AccountCreationInitial();
}

/// State for when the CreateAccountButtonPressed event fires to show loading
/// indicator
class AccountCreationLoading extends AccountCreationState {
  /// State for when the CreateAccountButtonPressed event fires to show loading
  /// indicator
  AccountCreationLoading();
}

/// State for when an AuthenticationException is thrown from the
/// AuthenticationService in creating an account
/// Used to show an error on the create account page
class AccountCreationFailure extends AccountCreationState {
  final String error;

  /// State for when an AuthenticationException is thrown from the
  /// AuthenticationService in creating an account
  /// Used to show an error on the create account page
  AccountCreationFailure({required this.error});

  @override
  List<Object> get props => [error];
}
