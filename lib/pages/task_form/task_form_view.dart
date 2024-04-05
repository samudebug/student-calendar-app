import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/task_form/task_form_controller.dart';

class TaskForm extends StatelessWidget {
  TaskForm({super.key});
  final controller = Get.find<TaskFormController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => Scaffold(
            appBar: AppBar(
              actions: [
                if (controller.editing.value)
                  IconButton(
                      onPressed: () => controller.delete(),
                      icon: Icon(
                        Icons.delete,
                        color: context.theme.colorScheme.error,
                      ))
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => controller.submit(),
              label: const Text("Save"),
              icon: const Icon(Icons.save),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: controller.nameController,
                        validator: controller.validateName,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(hintText: "Name"),
                        style: context.theme.textTheme.displaySmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: controller.deliverDateController,
                        keyboardType: TextInputType.datetime,
                        validator: controller.validateDate,
                        decoration: InputDecoration(
                            hintText: "Deliver date",
                            suffix: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () =>
                                  controller.openDatePicker(context),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: controller.notesController,
                        validator: controller.validateNotes,
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        maxLength: 200,
                        decoration: InputDecoration(hintText: "Extra notes"),
                        style: context.theme.textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
