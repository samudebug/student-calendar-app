import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_calendar_app/pages/task/task_controller.dart';
import 'package:student_calendar_app/widgets/created_by_info.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key});
  final controller = Get.find<TaskPageController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => Theme(
            data: ThemeData(
              colorScheme: controller.currentColorScheme.value,
              useMaterial3: true,
            ),
            child: Scaffold(
              backgroundColor: controller.currentColorScheme.value.background,
              appBar: AppBar(),
              floatingActionButton: controller.canEdit.value
                  ? FloatingActionButton.extended(
                      onPressed: () => controller.openEdit(),
                      label: Text("Edit Task"),
                      icon: Icon(Icons.edit),
                    )
                  : null,
              body: Obx(() => controller.loading.value &&
                      controller.currentTask.value == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                controller.currentTask.value!.name,
                                style: context.theme.textTheme.displaySmall
                                    ?.copyWith(
                                        color: controller.currentColorScheme
                                            .value.onBackground),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Deliver Date: ${DateFormat('dd/MM/yyyy').format(controller.currentTask.value!.deliverDate)}",
                                style: context.theme.textTheme.titleSmall
                                    ?.copyWith(
                                        color: controller.currentColorScheme
                                            .value.onBackground),
                              ),
                            ),
                            if (controller.currentTask.value!.student != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CreatedByInfo(
                                  student:
                                      controller.currentTask.value!.student!,
                                ),
                              ),
                            Text(
                              controller.currentTask.value!.notes,
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(
                                      color: controller.currentColorScheme.value
                                          .onBackground),
                            )
                          ],
                        ),
                      ),
                    )),
            ),
          )),
    );
  }
}
