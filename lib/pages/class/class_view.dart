import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/class/class_controller.dart';
import 'package:student_calendar_app/widgets/default_app_bar.dart';
import 'package:student_calendar_app/widgets/task_element.dart';

class ClassPage extends StatelessWidget {
  ClassPage({super.key});
  final controller = Get.find<ClassPageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: Obx(() => controller.currentClass.value == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      controller.canFetchMore.value &&
                      !controller.isLoadingMore.value) {
                    controller.fetchTasks();
                  }
                  return true;
                },
                child: CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 100,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        controller.currentClass.value!.name,
                        style: context.theme.textTheme.displaySmall?.copyWith(
                            color: context.theme.colorScheme.onBackground),
                      ),
                    ),
                  ),
                  if (controller.tasks.isEmpty && !controller.loading.value)
                    SliverToBoxAdapter(
                      child: Container(
                        height: 300,
                        child: Center(
                          child: Text("No tasks. All Clean!"),
                        ),
                      ),
                    ),
                  SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () => {},
                              child:
                                  TaskElement(task: controller.tasks[index]));
                        },
                        childCount: controller.tasks.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400.0,
                              mainAxisSpacing: 16.0,
                              crossAxisSpacing: 16.0,
                              mainAxisExtent: 150)),
                  if (controller.isLoadingMore.value)
                    SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: CircularProgressIndicator(),
                      ),
                    )
                ]),
              ),
            )),
    );
  }
}
