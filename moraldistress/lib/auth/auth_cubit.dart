import 'package:cognito_authentication_repository/cognito_authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final CognitoAuthenticationRepository authRepo;

  AuthCubit(this.authRepo) : super(UnknownAuthState());

  void signIn() async {
    try {
      if (await shouldClearState()) {
        await authRepo.signOut();
      }

      if (await authRepo.signInPrivateSession() &&
          await authRepo.isAuthorized()) {
        emit(Authenticated(userId: "foo"));
      } else {
        emit(Unauthenticated());
      }
    } catch (e, st) {
      print('signIn failed: $e');
      print(st);
      emit(Unauthenticated());
    }
  }

  /**
   * Carefully call signout to remove any old state. 
   * Docs warn of this -
   * https://docs.amplify.aws/lib/auth/signin/q/platform/flutter/#sign-in-a-user
   */
  Future<bool> shouldClearState() async {
    bool isauthn = await authRepo.isAuthenticated();
    if (!isauthn) {
      return false;
    }

    bool isauthz = await authRepo.isAuthorized();
    return isauthz != isauthn;
  }

  void signOut() async {
    try {
      await authRepo.signOut();
      emit(Unauthenticated());
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void attemptAutoSignIn() async {
    try {
      if (await authRepo.isAuthenticated() && await authRepo.isAuthorized()) {
        emit(Authenticated(userId: "foo"));
      } else {
        emit(Unauthenticated());
      }
    } on Exception {
      emit(Unauthenticated());
    }
  }
}
