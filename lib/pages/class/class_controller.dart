import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/models/models.dart';
import 'package:student_calendar_app/core/repositories/classes/classes_repository.dart';
import 'package:student_calendar_app/core/repositories/tasks/tasks_repository.dart';

class ClassPageController extends GetxController {
  final repo = Get.find<ClassesRepository>();
  final tasksRepo = Get.find<TasksRepository>();
  final currentClass = Rx<Class?>(null);
  final tasks = <Task>[].obs;
  final loading = true.obs;
  final isLoadingMore = false.obs;
  final canFetchMore = true.obs;
  int currentPage = 0;

  ClassPageController() {
    fetchData();
  }

  fetchData() async {
    final classId = Get.parameters['classId'];
    if (classId == null) return;
    currentClass.value = await repo.getClass(id: classId);
    await fetchTasks();
  }

  fetchTasks() async {
    try {
      if (canFetchMore.value) {
        isLoadingMore.value = true;
        currentPage++;
        final results =
            await tasksRepo.getTasksByClassId(classId: currentClass.value!.id, page: currentPage);
        final totalPages = (results.total / 30).ceil();
        canFetchMore.value = currentPage < totalPages;
        tasks.addAll(results.results);
        loading.value = false;
        isLoadingMore.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", "An error has ocurred");
      log(e.toString(), error: e);
    }
  }
}
