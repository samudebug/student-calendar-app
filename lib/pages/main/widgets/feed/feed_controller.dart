import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/repositories/feed/feed_repository.dart';
import 'package:student_calendar_app/core/repositories/feed/feed_section.dart';

class FeedController extends GetxController {
  final feed = <FeedSection>[].obs;
  final repo = Get.find<FeedRepository>();
  final loading = true.obs;
  final canFetchMore = true.obs;
  int currentPage = 0;


  FeedController() {
    fetchFeed();
  }
  fetchFeed() async {
    try {
      if (canFetchMore.value) {
        loading.value = true;
        currentPage++;
        final (totalPages, results) = await repo.fetchFeed(page: currentPage);
        canFetchMore.value = currentPage < totalPages;
        feed.addAll(results);
        loading.value = false;

      }
    } catch (e) {
      Get.snackbar("Error", "An error has ocurred");
      log(e.toString());
    }
  }
}
