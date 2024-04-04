import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/models/student.dart';

class CreatedByInfo extends StatelessWidget {
  const CreatedByInfo({super.key, required this.student});
  final Student student;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      direction: Axis.horizontal,
      children: [
        const Text("Created By:"),
        Text(student.name),
        CircleAvatar(
          radius: 10,
          backgroundColor: Get.theme.colorScheme.primary,
          backgroundImage:
              student.photoUrl.isEmpty ? null : NetworkImage(student.photoUrl),
          child: student.photoUrl.isEmpty
              ? Text(
                  student.name.isEmpty ? '' : student.name[0].toUpperCase(),
                  style: Get.theme.textTheme.bodySmall
                      ?.copyWith(color: Get.theme.colorScheme.onPrimary),
                )
              : null,
        )
      ],
    );
  }
}
