import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_calendar_app/core/models/models.dart';

class TaskElement extends StatelessWidget {
  const TaskElement({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              task.name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
                "Date: ${DateFormat('dd/MM/yyyy').format(task.deliverDate)}"),
          ),
        ],
      ),
    );
  }
}
