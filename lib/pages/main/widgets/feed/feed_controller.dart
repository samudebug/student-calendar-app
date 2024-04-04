import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/repositories/feed/feed_repository.dart';
import 'package:student_calendar_app/core/repositories/feed/feed_section.dart';

class FeedController extends GetxController {
  final feed = <FeedSection>[].obs;
  final repo = Get.find<FeedRepository>();
  final loading = true.obs;
  final isLoadingMore = false.obs;
  final canFetchMore = true.obs;
  int currentPage = 0;

  FeedController() {
    fetchFeed();
  }
  refresh() async {
    loading.value = true;
    canFetchMore.value = true;
    currentPage = 0;
    feed.clear();
    await fetchFeed();
  }

  fetchFeed() async {
    try {
      if (canFetchMore.value) {
        isLoadingMore.value = true;
        currentPage++;
        final (totalPages, results) = await repo.fetchFeed(page: currentPage);
        canFetchMore.value = currentPage < totalPages;
        // merging results
        feed.forEach((element) {
          final elementInResult =
              results.firstWhereOrNull((e) => e.date == element.date);
          if (elementInResult != null) {
            element.tasks.addAll(elementInResult.tasks);
            results.removeWhere((e) => e.date == element.date);
          }
        });
        feed.addAll(results);
        loading.value = false;
        isLoadingMore.value = false;

      }
    } catch (e) {
      Get.snackbar("Error", "An error has ocurred");
      log(e.toString(), error: e);
    }
  }
}
