import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/students/students_controller.dart';

class StudentsPage extends StatelessWidget {
  StudentsPage({super.key});
  final controller = Get.find<StudentsPageController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(() => controller.loading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Get.theme.colorScheme.primary,
                      backgroundImage: controller
                              .students[index].photoUrl.isEmpty
                          ? null
                          : NetworkImage(controller.students[index].photoUrl),
                      child: controller.students[index].photoUrl.isEmpty
                          ? Text(
                              controller.students[index].name.isEmpty
                                  ? ''
                                  : controller.students[index].name[0]
                                      .toUpperCase(),
                              style: Get.theme.textTheme.bodySmall?.copyWith(
                                  color: Get.theme.colorScheme.onPrimary),
                            )
                          : null,
                    ),
                    title: Text(controller.students[index].name),
                    trailing: controller.canDelete.value &&
                            controller.students[index].userId !=
                                controller.userId
                        ? IconButton(
                            onPressed: () => controller
                                .removeStudent(controller.students[index]),
                            icon: Icon(
                              Icons.delete,
                              color: context.theme.colorScheme.error,
                            ))
                        : null),
                itemCount: controller.students.length,
              ),
            )),
    ));
  }
}
