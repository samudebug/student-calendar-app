import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/repositories/classes/classes_repository.dart';

class JoinClassDialogController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  final repo = Get.find<ClassesRepository>();
  final loading = false.obs;

  submit() async {
    if ((formKey.currentState?.validate() ?? false)) {
      try {
        loading.value = true;
        final joinedClass = await repo.joinClass(code: codeController.text);
        Get.back();
        Get.toNamed('/classes/${joinedClass.id}');
      } catch (e) {
        Get.snackbar("Error", e.toString(), backgroundColor: Get.theme.colorScheme.error, colorText: Get.theme.colorScheme.onError);
      } finally {
        loading.value = false;
      }
    }
  }

  String? validateCode(String? code) {
    if (code?.isEmpty ?? true) {
      return 'Code cannot be empty';
    }
    if ((code?.length ?? 0) > 5) {
      return 'Code cannot have more than 5 characters';
    }

    if (!RegExp(r'^([A-Z0-9]){5}$').hasMatch(code ?? '')) {
      return 'This code is invalid';
    }
    return null;
  }
}
