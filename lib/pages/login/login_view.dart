import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controller = Get.find<LoginPageController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Login",
                    style: Get.theme.textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: "Email"),
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: "Password"),
                    obscureText: true,
                    controller: controller.passwordController,
                    validator: controller.validatePassword,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password",
                        style: Get.theme.textTheme.labelSmall?.copyWith(
                            color: Get.theme.colorScheme.primary),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => controller.submit(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.colorScheme.primary,
                        foregroundColor: Get.theme.colorScheme.onPrimary),
                    child: const Text("Login"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton.icon(
                    icon: SvgPicture.asset('assets/google.svg', height: 20,),
                    onPressed: () => controller.loginWithGoogle(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.colorScheme.tertiary,
                        foregroundColor: Get.theme.colorScheme.onTertiary),
                    label: const Text("Login With Google"),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text("Or", textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: () => controller.openSignup(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.colorScheme.secondary,
                        foregroundColor: Get.theme.colorScheme.onSecondary),
                    child: const Text("Sign Up"),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
