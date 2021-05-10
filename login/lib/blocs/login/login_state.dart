import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

/// State for when the login page loads and shows the login page
class LoginInitial extends LoginState {
  /// State for when the login page loads and shows the login page
  LoginInitial();
}

/// State for when LoginInWithEmailButtonPressed event fires and the
/// authentication service is in the process of attempting to authenticate the
/// user with the provided credentials
class LoginLoading extends LoginState {
  /// State for when LoginInWithEmailButtonPressed event fires and the
  /// authentication service is in the process of attempting to authenticate the
  /// user with the provided credentials
  LoginLoading();
}

/// State that holds a message string for the error when an
/// AuthenticationException is thrown during an LoginInWithEmailButtonPressed
/// event
class LoginFailure extends LoginState {
  final String error;

  /// State that holds a message string for the error when an
  /// AuthenticationException is thrown during an LoginInWithEmailButtonPressed
  /// event
  LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
