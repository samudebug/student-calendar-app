import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/services/auth_service.dart';

class LoginPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final service = Get.find<AuthService>();

  submit() async {
    if (formKey.currentState?.validate() ?? false) {
      await service.login(
          email: emailController.text, password: passwordController.text);
      Get.offAndToNamed('/');
    }
  }

  loginWithGoogle() async {
    await service.loginWithGoogle();
    Get.offAndToNamed('/');
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validatePassword(String? password) {
    if (password?.isEmpty ?? true) {
      return 'This field is required';
    }
    if ((password?.length ?? 0) < 6) {
      return 'Password must have at least 6 characters';
    }
    return null;
  }

  openSignup() {
    Get.toNamed('/signup');
  }
}
