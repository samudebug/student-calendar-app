import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_calendar_app/core/models/models.dart';
import 'package:student_calendar_app/widgets/created_by_info.dart';

class TaskElement extends StatelessWidget {
  TaskElement({super.key, required this.task});
  final Task task;
  final colors = <String, Color>{
    'green': Colors.green,
    'red': Colors.red,
    'orange': Colors.orange,
    'indigo': Colors.indigo,
    'deepPurple': Colors.deepPurple,
    'teal': Colors.teal,
    'amber': Colors.amber
  };
  late final selectedKey =
      colors.keys.toList()[Random().nextInt(colors.keys.toList().length)];
  late final currentColorScheme = ColorScheme.fromSeed(
      seedColor: colors[selectedKey]!, brightness: Get.theme.brightness);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
          '/classes/${task.classId}/tasks/${task.id}?color=$selectedKey'),
      child: Theme(
        data: ThemeData(
          colorScheme: currentColorScheme,
          useMaterial3: true,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: currentColorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  task.name,
                  style: Get.theme.textTheme.titleLarge
                      ?.copyWith(color: currentColorScheme.onSurfaceVariant),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Date: ${DateFormat('dd/MM/yyyy').format(task.deliverDate)}",
                  style: Get.theme.textTheme.titleSmall
                      ?.copyWith(color: currentColorScheme.onSurfaceVariant),
                ),
              ),
              if (task.student != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CreatedByInfo(
                    student: task.student!,
                  ),
                ),
              if (task.currentClass != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Wrap(
                    spacing: 8,
                    direction: Axis.horizontal,
                    children: [
                      const Text("Class:"),
                      Text(task.currentClass!.name),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
