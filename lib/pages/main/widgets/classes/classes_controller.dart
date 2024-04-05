import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/models/models.dart';
import 'package:student_calendar_app/core/repositories/classes/classes_repository.dart';
import 'package:student_calendar_app/core/repositories/messaging/messaging_repository.dart';
import 'package:student_calendar_app/core/services/auth_service.dart';

class ClassesController extends GetxController {
  final classes = <Class>[].obs;
  final authService = Get.find<AuthService>();

  final repo = Get.find<ClassesRepository>();
  final messagingRepo = Get.find<MessagingRepository>();
  final loading = true.obs;
  final isLoadingMore = false.obs;
  final canFetchMore = true.obs;

  int currentPage = 0;

  ClassesController() {
    fetchClasses();
  }

  refresh() async {
    loading.value = true;
    canFetchMore.value = true;
    currentPage = 0;
    classes.clear();
    await fetchClasses();
  }

  fetchClasses() async {
    try {
      if (canFetchMore.value && authService.user != null ) {
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
