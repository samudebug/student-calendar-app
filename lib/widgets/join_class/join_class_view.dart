import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/widgets/join_class/join_class_controller.dart';


class JoinClassDialog extends StatelessWidget {
  JoinClassDialog({super.key});
  final controller = Get.find<JoinClassDialogController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Enter the code for the class",
                style: context.theme.textTheme.titleLarge,
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "Class Code"),
                  textCapitalization: TextCapitalization.characters,
                  controller: controller.codeController,
                  validator: controller.validateCode,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Obx(() => IgnorePointer(
                    ignoring: controller.loading.value,
                    child: ElevatedButton(
                      onPressed: () => controller.submit(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.theme.colorScheme.primary,
                          foregroundColor: context.theme.colorScheme.onPrimary),
                      child: const Text("Save"),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}