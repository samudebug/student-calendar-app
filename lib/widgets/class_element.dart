import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/models/models.dart';

class ClassElement extends StatelessWidget {
  const ClassElement({super.key, required this.currentClass});
  final Class currentClass;
  @override
  Widget build(BuildContext context) {
        return Container(
      decoration: BoxDecoration(
          color: Get.theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              currentClass.name,
              style: Get.theme
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Get.theme.colorScheme.onSurface),
            ),
          )
        ],
      ),
    );
  }
}