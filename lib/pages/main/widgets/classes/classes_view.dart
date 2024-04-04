import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/main/widgets/classes/classes_controller.dart';
import 'package:student_calendar_app/widgets/class_element.dart';

class ClassesView extends StatelessWidget {
  ClassesView({super.key});
  final controller = Get.find<ClassesController>();
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification &&
            controller.canFetchMore.value && !controller.isLoadingMore.value) {
          controller.fetchClasses();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async => controller.refresh(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.centerLeft,
                height: 100,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Classes",
                  style: context.theme.textTheme.displaySmall
                      ?.copyWith(color: context.theme.colorScheme.onBackground),
                ),
              ),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () =>
                            controller.openClass(controller.classes[index]),
                        child: ClassElement(
                            currentClass: controller.classes[index]));
                  },
                  childCount: controller.classes.length,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    mainAxisExtent: 80)),
            if (controller.isLoadingMore.value)
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
