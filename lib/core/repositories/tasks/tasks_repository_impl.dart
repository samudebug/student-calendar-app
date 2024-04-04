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
}
