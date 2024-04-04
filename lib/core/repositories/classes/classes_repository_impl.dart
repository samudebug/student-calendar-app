import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/environment.dart';
import 'package:student_calendar_app/core/models/class.dart';
import 'package:student_calendar_app/core/models/paginated_result.dart';
import 'package:student_calendar_app/core/repositories/auth/auth_repository.dart';
import 'package:student_calendar_app/core/repositories/classes/classes_repository.dart';

class ClassesRepositoryImpl extends GetConnect implements ClassesRepository {
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
  Future<PaginatedResult<Class>> getClasses({int? page = 1}) async {
    final response = await get('/classes', query: {'page': page.toString()});
    final List<Class> classes = (response.body['results'] as List<dynamic>)
        .map((e) => Class.fromJson(e))
        .toList();
    return PaginatedResult(
        total: response.body['total'],
        page: int.parse(response.body['page']),
        results: classes);
  }

  @override
  Future<Class> getClass({required String id}) async {
    final response = await get('/classes/$id');
    final Class result = Class.fromJson(response.body);
    return result;
  }

  @override
  Future<Class> createClass({required String name}) async {
    final response = await post('/classes', {'name': name});
    if (response.statusCode != 201) {
      throw ("An error has ocurred while creating the class");
    }
    final Class result = Class.fromJson(response.body);
    return result;
  }
}
