import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/models/notification.dart';
import 'package:student_calendar_app/core/repositories/notifications/notifications_repository.dart';

class NotificationsPageController extends GetxController {
  final repo = Get.find<NotificationsRepository>();
  final notifications = <Notification>[].obs;
  final loading = true.obs;
  final isLoadingMore = false.obs;
  final canFetchMore = true.obs;
  int currentPage = 0;

  NotificationsPageController() {
    getData();
  }

  refresh() async {
    loading.value = true;
    canFetchMore.value = true;
    currentPage = 0;
    notifications.clear();
    await getData();
  }

  getData() async {
    try {
      if (canFetchMore.value) {
        isLoadingMore.value = true;
        currentPage++;
        final results = await repo.getNotifications(page: currentPage);
        final totalPages = (results.total / 30).ceil();
        canFetchMore.value = currentPage < totalPages;
        notifications.addAll(results.results);
        loading.value = false;
        isLoadingMore.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", "An error has ocurred");
      log(e.toString(), error: e);
    }
  }
}
