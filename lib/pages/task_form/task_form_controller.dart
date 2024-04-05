import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_calendar_app/core/models/models.dart';
import 'package:student_calendar_app/core/repositories/tasks/tasks_repository.dart';

class TaskFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final editing = false.obs;
  final nameController = TextEditingController();
  final notesController = TextEditingController();
  final deliverDateController = TextEditingController();
  final currentDate = DateTime.now().obs;
  final repo = Get.find<TasksRepository>();
  final currentTask = Rx<Task?>(null);
  final classId = ''.obs;

  TaskFormController() {
    getData();
  }

  submit() async {
    if ((formKey.currentState?.validate() ?? false)) {
      log("Validated");
      if (editing.value) {
        await repo.updateTask(
            classId: classId.value,
            taskId: currentTask.value!.id,
            name: nameController.text,
            deliverDate:
                DateFormat('dd/MM/yyyy').parse(deliverDateController.text),
            notes: notesController.text);
      } else {
        await repo.createTask(
            classId: classId.value,
            name: nameController.text,
            deliverDate:
                DateFormat('dd/MM/yyyy').parse(deliverDateController.text),
            notes: notesController.text);
      }
      Get.back(closeOverlays: false);
      Get.snackbar("Saved!", "The task was saved successfully!");
    }
  }

  getData() async {
    final classId = Get.parameters['classId'];
    if (classId == null) return;
    this.classId.value = classId;
    final taskId = Get.parameters['taskId'];
    if (taskId != null) {
      currentTask.value = await repo.getTask(classId: classId, taskId: taskId);
      editing.value = true;
      nameController.text = currentTask.value!.name;
      deliverDateController.text =
          DateFormat('dd/MM/yyyy').format(currentTask.value!.deliverDate);
      currentDate.value = currentTask.value!.deliverDate;
      notesController.text = currentTask.value!.notes;
    }
  }

  delete() async {
    Get.defaultDialog(
        title: "Are you sure you want to delete this task?",
        middleText: "This action cannot be reverted",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () async {
          await repo.deleteTask(
              classId: classId.value, taskId: currentTask.value!.id);
          log("Class Id ${classId.value}");
          Get.offNamedUntil('/classes/${classId.value}',
              (route) => !(route.settings.name?.contains('tasks') ?? true));
        });
  }

  String? validateName(String? name) {
    if (name?.isEmpty ?? false) {
      return 'Name cannot be empty';
    }
    if ((name?.length ?? 0) > 200) {
      return 'Name cannot have more than 200 characters';
    }
    return null;
  }

  String? validateNotes(String? notes) {
    if ((notes?.length ?? 0) > 200) {
      return 'Notes cannot have more than 200 characters';
    }
    return null;
  }

  String? validateDate(String? date) {
    if (!RegExp(r'^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$').hasMatch(date ?? '')) {
      return 'Date must be in dd/MM/yyyy format';
    }
    return null;
  }

  openDatePicker(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: currentDate.value,
        lastDate: DateTime(DateTime.now().year + 5));
    if (date != null) {
      deliverDateController.text = DateFormat('dd/MM/yyyy').format(date);
    }
  }
}
