import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/repositories/classes/classes_repository.dart';

class CreateClassDialogController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final repo = Get.find<ClassesRepository>();
  final loading = false.obs;

  submit() async {
    if ((formKey.currentState?.validate() ?? false)) {
      try {
        loading.value = true;
        final createdClass = await repo.createClass(name: nameController.text);
        Get.back();
        Get.toNamed('/classes/${createdClass.id}');
      } catch (e) {
        Get.snackbar("Error", e.toString());
      } finally {
        loading.value = false;
      }
    }
  }

  String? validateName(String? name) {
    if (name?.isEmpty ?? true) {
      return 'Name cannot be empty';
    }
    if ((name?.length ?? 0) > 200) {
      return 'Name cannot have more than 200 characters';
    }
    return null;
  }
}
