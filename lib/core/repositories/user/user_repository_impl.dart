import 'dart:developer';

import 'package:get/get.dart';
import 'package:student_calendar_app/core/environment.dart';
import 'package:student_calendar_app/core/repositories/auth/auth_repository.dart';
import 'package:student_calendar_app/core/repositories/user/user_repository.dart';

class UserRepositoryImpl extends GetConnect implements UserRepository {
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
  Future<void> updateUser({required String fcmToken, required String name}) async {
    final response = await patch('/users/me', {'fcmToken': fcmToken, 'name': name});
    log("Response code ${response.statusCode}");
    log("Response body ${response.body}");
  }
}
