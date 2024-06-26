import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/models/models.dart';
import 'package:student_calendar_app/core/repositories/tasks/tasks_repository.dart';
import 'package:student_calendar_app/core/services/auth_service.dart';

class TaskPageController extends GetxController {
  final repo = Get.find<TasksRepository>();
  final authService = Get.find<AuthService>();
  final currentTask = Rx<Task?>(null);
  final loading = true.obs;
  final canEdit = false.obs;
  final colors = <String, Color>{
    'green': Colors.green,
    'red': Colors.red,
    'orange': Colors.orange,
    'indigo': Colors.indigo,
    'deepPurple': Colors.deepPurple,
    'teal': Colors.teal,
    'amber': Colors.amber
  };
  late final currentColorScheme = ColorScheme.fromSeed(
          seedColor: colors[colors.keys
              .toList()[Random().nextInt(colors.keys.toList().length)]]!,
          brightness: Get.theme.brightness)
      .obs;

  TaskPageController() {
    fetchData();
    fetchTheme();
  }

  fetchTheme() {
    final color = Get.parameters['color'];
    if (color != null) {
      currentColorScheme.value = ColorScheme.fromSeed(
          seedColor: colors[color]!, brightness: Get.theme.brightness);
    }
  }

  fetchData() async {
    final classId = Get.parameters['classId'];
    final taskId = Get.parameters['taskId'];
    if (classId == null) return;
    if (taskId == null) return;
    try {
      currentTask.value = await repo.getTask(classId: classId, taskId: taskId);
      canEdit.value =
          currentTask.value!.student?.userId == authService.user?.uid;
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Get.theme.colorScheme.error);
    } finally {
      loading.value = false;
    }
  }

  openEdit() async {
    await Get.toNamed(
        '/classes/${currentTask.value!.classId}/tasks/${currentTask.value!.id}/edit');
    fetchData();
  }
}
