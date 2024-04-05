import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/environment.dart';
import 'package:student_calendar_app/core/models/notification.dart';
import 'package:student_calendar_app/core/models/paginated_result.dart';
import 'package:student_calendar_app/core/repositories/auth/auth_repository.dart';
import 'package:student_calendar_app/core/repositories/messaging/messaging_repository.dart';
import 'package:student_calendar_app/core/repositories/notifications/notifications_repository.dart';
import 'package:student_calendar_app/core/repositories/user/user_repository.dart';

class NotificationsRepositoryImpl extends GetConnect
    implements NotificationsRepository {
  final authRepo = Get.find<AuthRepository>();
  final messagingRepo = Get.find<MessagingRepository>();
  final userRepo = Get.find<UserRepository>();
  NotificationsRepositoryImpl() {
    messagingRepo.requestPermission();
    messagingRepo.getToken().then((value) {
      if (value != null) {
        userRepo.updateUser(
            fcmToken: value, name: authRepo.currentUser().displayName);
      }
    });
    messagingRepo.onTokenRefresh.listen((event) {
      userRepo.updateUser(
          fcmToken: event, name: authRepo.currentUser().displayName);
    });
    messagingRepo.onForegroundMessage.listen((RemoteMessage event) {
      Get.snackbar(event.data['title'], event.data['body']);
    });
  }
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
  Future<PaginatedResult<Notification>> getNotifications(
      {int? page = 1}) async {
    final afterDate = DateTime.now().copyWith(hour: 0, minute: 0);
    final response = await get('/notifications', query: {
      'page': page.toString(),
      'afterDate': "${afterDate.toIso8601String()}Z"
    });
    final List<Notification> notifications =
        (response.body['results'] as List<dynamic>)
            .map((e) => Notification.fromJson(e))
            .toList();
    return PaginatedResult(
        total: response.body['total'],
        page: int.parse(response.body['page']),
        results: notifications);
  }
}
