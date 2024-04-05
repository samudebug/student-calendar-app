import 'package:student_calendar_app/core/models/models.dart';

abstract class TasksRepository {
  Future<PaginatedResult<Task>> getTasksByClassId(
      {required String classId, int? page});
  Future<Task> getTask({required String classId, required String taskId});
  Future<Task> createTask(
      {required String classId,
      required String name,
      required DateTime deliverDate,
      required String notes});
  Future<Task> updateTask(
      {required String classId,
      required String taskId,
      String? name,
      DateTime? deliverDate,
      String? notes});
  Future<void> deleteTask({required String classId, required String taskId});
}
