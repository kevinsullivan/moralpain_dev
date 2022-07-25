import 'package:cognito_authentication_repository/cognito_authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final authRepo = CognitoAuthenticationRepository();

  AuthCubit() : super(UnknownAuthState());

  void signIn() async {
    try {
      // Call signout to remove any old state. Docs warn of this -
      // https://docs.amplify.aws/lib/auth/signin/q/platform/flutter/#sign-in-a-user
      if (!await authRepo.isAuthenticated() || !await authRepo.isAuthorized()) {
        signOut();
      }

      if (await authRepo.signIn() && await authRepo.isAuthorized()) {
        emit(Authenticated(userId: "foo"));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
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
