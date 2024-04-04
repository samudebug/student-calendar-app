import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/repositories/auth/auth_repository.dart';

class AuthService extends GetxService {
  final repo = Get.find<AuthRepository>();

  login({required String email, required String password}) async {
    repo.login(email: email, password: password);
  }

  loginWithGoogle() {
    return repo.loginWithGoogle();
  }

  signUp(
      {required String name,
      required String email,
      required String password}) async {
    repo.signUp(name: name, email: email, password: password);
  }

  signOut() {
    return repo.signOut();
  }

  checkUserLoggedIn() {
    repo.userChanges.listen((event) {
      if (event == null) {
        Get.offAllNamed('/login');
      }
    });
  }

  get user => repo.currentUser();
}
