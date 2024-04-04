import 'package:student_calendar_app/core/models/models.dart';

abstract class TasksRepository {
  Future<PaginatedResult<Task>> getTasksByClassId({required String classId, int? page});
  Future<Task> getTask({required String classId, required String taskId});
}