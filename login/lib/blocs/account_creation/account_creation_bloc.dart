import 'package:bloc/bloc.dart';
import 'account_creation_event.dart';
import 'account_creation_state.dart';
import '../authentication/authentication.dart';
import '../../exceptions/exceptions.dart';
import '../../services/services.dart';

class AccountCreationBloc
    extends Bloc<AccountCreationEvent, AccountCreationState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  AccountCreationBloc(AuthenticationBloc authenticationBloc,
      AuthenticationService authenticationService)
      : _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(AccountCreationInitial());

  @override
  Stream<AccountCreationState> mapEventToState(
      AccountCreationEvent event) async* {
    if (event is CreateAccountButtonPressed) {
      // Example of using a helper map function for the state
      // yield* _mapCreateAccountButtonToState(event);
      yield AccountCreationLoading();
      try {
        final user =
            await _authenticationService.createAccountWithEmailAndPassword(
          event.email,
          event.password,
          event.confirmPassword,
        );
        _authenticationBloc.add(UserLoggedIn(user: user));
      } on AuthenticationException catch (e) {
        yield AccountCreationFailure(error: e.message);
        print(e);
      }
    }
  }

  // Stream<AccountCreationState> _mapCreateAccountButtonToState(
  //     CreateAccountButtonPressed event) async* {
  //   yield AccountCreationLoading();
  //   try {
  //     final user =
  //         await _authenticationService.createAccountWithEmailAndPassword(
  //       event.email,
  //       event.password,
  //       event.confirmPassword,
  //     );
  //     _authenticationBloc.add(UserLoggedIn(user: user));
  //   } on AuthenticationException catch (e) {
  //     yield AccountCreationFailure(error: e.message);
  //     print(e);
  //   }
  // }
}
