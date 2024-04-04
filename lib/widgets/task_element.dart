import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_calendar_app/core/models/models.dart';

class TaskElement extends StatelessWidget {
  TaskElement({super.key, required this.task});
  final Task task;
  final colors = [
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.indigo,
    Colors.deepPurple,
    Colors.teal,
    Colors.amber
  ];
  late final currentColorScheme = ColorScheme.fromSeed(
      seedColor: colors[Random().nextInt(colors.length)],
      brightness: Get.theme.brightness);
  @override
  Widget build(BuildContext context) {
    return Theme(
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
          ],
        ),
      ),
    );
  }
}
