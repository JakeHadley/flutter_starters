import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../exceptions/exceptions.dart';
import '../models/models.dart' as local;

abstract class AuthenticationService {
  local.User? getCurrentUser();
  Future<local.User> signInWithEmailAndPassword(String email, String password);
  Future<void>? signOut();
  Future<local.User> createAccountWithEmailAndPassword(
      String email, String confirmEmail, String password);
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  local.User? getCurrentUser() {
    print('hello there');
    fb.User? firebaseUser = fb.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      return local.User(
          email: firebaseUser.email, name: firebaseUser.displayName);
    } else {
      return null;
    }
  }

  @override
  Future<local.User> createAccountWithEmailAndPassword(
      String email, String password, String confirmPassword) async {
    if (email.isEmpty) {
      throw AuthenticationException(message: 'Email cannot be blank');
    }
    if (password.isEmpty || confirmPassword.isEmpty) {
      throw AuthenticationException(message: 'Password fields cannot be blank');
    }
    if (password != confirmPassword) {
      throw AuthenticationException(message: 'Passwords must match');
    }
    try {
      fb.UserCredential userCredential =
          await fb.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return local.User(
          name: userCredential.user!.displayName,
          email: userCredential.user!.email);
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthenticationException(
            message: 'Password must be at least 6 characters');
      }
      if (e.code == 'invalid-email') {
        throw AuthenticationException(message: 'Invalid Email Address');
      }
      if (e.code == 'email-already-in-use') {
        throw AuthenticationException(message: 'Email already in use');
      }
      print(e.code);
      throw AuthenticationException(message: 'Bad');
    }
  }

  @override
  Future<local.User> signInWithEmailAndPassword(
      String email, String password) async {
    if (email.isEmpty) {
      throw AuthenticationException(message: 'Email cannot be blank');
    }
    if (password.isEmpty) {
      throw AuthenticationException(message: 'Password cannot be blank');
    }
    try {
      fb.UserCredential userCredential =
          await fb.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return local.User(
          name: userCredential.user!.displayName,
          email: userCredential.user!.email);
    } on fb.FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw AuthenticationException(message: 'Invalid Password');
      }
      if (e.code == 'invalid-email') {
        throw AuthenticationException(message: 'Invalid Email Address');
      }
      if (e.code == 'user-not-found') {
        throw AuthenticationException(message: 'Email not found');
      }
      print(e.code);
      throw AuthenticationException(message: 'Bad');
    }
  }

  @override
  Future<void> signOut() async {
    await fb.FirebaseAuth.instance.signOut();
  }
}
