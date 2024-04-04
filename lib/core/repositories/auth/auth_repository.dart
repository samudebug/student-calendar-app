import 'package:student_calendar_app/core/repositories/auth/user.dart';

abstract class AuthRepository {
  login({required String email, required String password});
  loginWithGoogle();
  signUp({required String name, required String email, required String password});
  signOut();
  currentUser();
  getToken();

  Stream<LocalUser?> get userChanges;
}