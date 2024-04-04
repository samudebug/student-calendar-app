import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/main/widgets/feed/feed_controller.dart';
import 'package:student_calendar_app/widgets/task_element.dart';
import 'package:collection/collection.dart';

class FeedView extends StatelessWidget {
  FeedView({super.key});
  final controller = Get.find<FeedController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : controller.feed.isEmpty
            ? const Center(
                child: Text("No tasks. All Clean!"),
              )
            : NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      controller.canFetchMore.value) {
                    controller.fetchFeed();
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: () async => controller.refresh(),
                  child: CustomScrollView(
                    slivers: controller.feed
                        .mapIndexed((sectionIndex, element) {
                          return [
                            SliverToBoxAdapter(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 100,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  element.date,
                                  style: context.theme.textTheme.displaySmall
                                      ?.copyWith(
                                          color: context
                                              .theme.colorScheme.onBackground),
                                ),
                              ),
                            ),
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return TaskElement(
                                        task: element.tasks[index]);
                                  },
                                  childCount: element.tasks.length,
                                ),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 400.0,
                                        mainAxisSpacing: 16.0,
                                        crossAxisSpacing: 16.0,
                                        mainAxisExtent: 150)),
                            SliverToBoxAdapter(
                              child: Container(
                                alignment: Alignment.center,
                                height:
                                    controller.isLoadingMore.value ? 100 : 0,
                                child: controller.isLoadingMore.value
                                    ? const CircularProgressIndicator()
                                    : Container(),
                              ),
                            )
                          ];
                        })
                        .toList()
                        .expand((element) => element)
                        .toList(),
                  ),
                ),
              ));
    // return Obx(() => RefreshIndicator(
    //   onRefresh: () async => controller.refresh(),
    //   child: ListView.builder(
    //         itemCount:
    //             controller.feed.length + (controller.canFetchMore.value ? 1 : 0),
    //         itemBuilder: (context, index) {
    //           if (index == controller.feed.length - 3 &&
    //               controller.canFetchMore.value) {
    //             controller.fetchFeed();
    //           }
    //           if (index == controller.feed.length) {
    //             return const Center(
    //                 child: Padding(
    //               padding: EdgeInsets.all(8),
    //               child: CircularProgressIndicator(),
    //             ));
    //           }
    //           final item = controller.feed[index];

    //           return Container(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 8.0),
    //                   child: Text(
    //                     item.date,
    //                     style: context.theme.textTheme.displayMedium
    //                         ?.copyWith(color: context.theme.colorScheme.onBackground),
    //                   ),
    //                 ),
    //                 ...item.tasks.map((e) => Padding(
    //                       padding: const EdgeInsets.symmetric(vertical: 8.0),
    //                       child: TaskElement(task: e),
    //                     ))
    //               ],
    //             ),
    //           );
    //         },
    //       ),
    // ));
  }
}
