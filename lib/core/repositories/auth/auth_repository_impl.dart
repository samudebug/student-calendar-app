import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student_calendar_app/core/repositories/auth/auth_repository.dart';
import 'package:student_calendar_app/core/repositories/auth/user.dart';

class AuthRepositoryFirebase implements AuthRepository {
  final instance = FirebaseAuth.instance;
  @override
  login({required String email, required String password}) async {
    try {
      await instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Get.snackbar("Error", "This email is invalid");
      } else if (e.code == 'user-disabled') {
        Get.snackbar("Error", "You are not authorized");
      } else if (e.code == 'user-not-found') {
        Get.snackbar("Error", "This user does not exist");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Your password is incorrect");
      } else {
        Get.snackbar("Error", "An error has ocurred");
        log(e.toString());
      }
    }
  }

  @override
  signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      await instance.createUserWithEmailAndPassword(
          email: email, password: password);
      return await instance.currentUser?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "This email is already in use");
      } else if (e.code == 'invalid-email') {
        Get.snackbar("Error", "This email is invalid");
      } else if (e.code == 'weak-password') {
        Get.snackbar("Error", "Your password is too weak");
      } else {
        Get.snackbar("Error", "An error has ocurred");
        
      }
      rethrow;
    }
  }

  @override
  currentUser() {
    return instance.currentUser;
  }

  @override
  loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await instance.signInWithCredential(credential);
  }

  Stream<LocalUser?> get userChanges =>
      instance.userChanges().map((event) => event != null
          ? LocalUser(
              id: event.uid,
              name: event.displayName ?? '',
              email: event.email ?? '',
              photoURL: event.photoURL ?? '')
          : null);

  @override
  signOut() {
    return instance.signOut();
  }

  @override
  getToken() {
    return instance.currentUser?.getIdToken();
  }
}
