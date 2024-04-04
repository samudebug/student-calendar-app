import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/models/models.dart';
import 'package:student_calendar_app/core/repositories/classes/classes_repository.dart';

class ClassesController extends GetxController {
  final classes = <Class>[].obs;
  final repo = Get.find<ClassesRepository>();
  final loading = true.obs;
  final isLoadingMore = false.obs;
  final canFetchMore = true.obs;
  int currentPage = 0;

  ClassesController() {
    fetchClasses();
  }

  fetchClasses() async {
    try {
      if (canFetchMore.value) {
        isLoadingMore.value = true;
        currentPage++;
        final results = await repo.getClasses(page: currentPage);
        final totalPages = (results.total / 30).ceil();
        canFetchMore.value = currentPage < totalPages;
        classes.addAll(results.results);
        loading.value = false;
        isLoadingMore.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", "An error has ocurred");
      log(e.toString(), error: e);
    }
  }

  openClass(Class currentClass) {
    Get.toNamed('/classes/${currentClass.id}');
  }
}
