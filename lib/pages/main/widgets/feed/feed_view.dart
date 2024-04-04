import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/models/models.dart';
import 'package:student_calendar_app/pages/main/widgets/feed/feed_controller.dart';
import 'package:student_calendar_app/widgets/task_element.dart';

class FeedView extends StatelessWidget {
  FeedView({super.key});
  final controller = Get.find<FeedController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount:
              controller.feed.length + (controller.canFetchMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.feed.length - 3 &&
                controller.canFetchMore.value) {
              controller.fetchFeed();
            }
            if (index == controller.feed.length) {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ));
            }
            final item = controller.feed[index];

            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      item.date,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  ...item.tasks.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TaskElement(task: e),
                      ))
                ],
              ),
            );
          },
        ));
  }
}
