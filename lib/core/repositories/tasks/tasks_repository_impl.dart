import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/environment.dart';
import 'package:student_calendar_app/core/models/paginated_result.dart';
import 'package:student_calendar_app/core/models/task.dart';
import 'package:student_calendar_app/core/repositories/auth/auth_repository.dart';
import 'package:student_calendar_app/core/repositories/tasks/tasks_repository.dart';

class TasksRepositoryImpl extends GetConnect implements TasksRepository {
  final authRepo = Get.find<AuthRepository>();

  @override
  void onInit() {
    httpClient.baseUrl = '${Environment.apiUrl}';

    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await authRepo.getToken();
      request.headers['Authorization'] = token;
      return request;
    });
    httpClient.timeout = Duration(seconds: 30);
  }

  @override
  Future<PaginatedResult<Task>> getTasksByClassId(
      {required String classId, int? page = 1}) async {
    final afterDate = DateTime.now().copyWith(hour: 0, minute: 0);
    final response = await get('/classes/$classId/tasks', query: {
      'page': page.toString(),
      'afterDate': "${afterDate.toIso8601String()}Z"
    });
    final List<Task> classes = (response.body['results'] as List<dynamic>)
        .map((e) => Task.fromJson(e))
        .toList();
    return PaginatedResult(
        total: response.body['total'],
        page: int.parse(response.body['page']),
        results: classes);
  }

  @override
  Future<Task> getTask(
      {required String classId, required String taskId}) async {
    final response = await get('/classes/$classId/tasks/$taskId');
    if (response.statusCode == 404) {
      throw ("Task not found");
    }
    if (response.statusCode != 200) {
      log("Status Code: ${response.statusCode}", name: "TasksRepository");
      log("Body: ${response.body}", name: "TasksRepository");
      throw ("An error has ocurred");
    }
    final result = Task.fromJson(response.body);
    return result;
  }

  @override
  Future<Task> createTask(
      {required String classId,
      required String name,
      required DateTime deliverDate,
      required String notes}) async {
    final response = await post('/classes/$classId/tasks', {
      'name': name,
      'deliverDate': "${deliverDate.toIso8601String()}Z",
      'notes': notes
    });
    if (response.statusCode != 201) {
      throw ("An error has ocurred while creating the task");
    }
    final Task result = Task.fromJson(response.body);
    return result;
  }

  @override
  Future<Task> updateTask(
      {required String classId,
      required String taskId,
      String? name,
      DateTime? deliverDate,
      String? notes}) async {
    final body = <String, dynamic>{};
    if (name != null) {
      body['name'] = name;
    }
    if (deliverDate != null) {
      body['deliverDate'] = "${deliverDate.toIso8601String()}Z";
    }
    if (name != null) {
      body['notes'] = notes;
    }
    final response = await patch('/classes/$classId/tasks/$taskId', body);
    if (response.statusCode != 200) {
      throw ("An error has ocurred while updating the task");
    }
    final Task result = Task.fromJson(response.body);
    return result;
  }

  @override
  Future<void> deleteTask(
      {required String classId, required String taskId}) async {
    await delete('/classes/$classId/tasks/$taskId');
  }
}
