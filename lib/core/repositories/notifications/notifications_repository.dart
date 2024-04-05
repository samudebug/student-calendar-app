import 'package:student_calendar_app/core/models/models.dart';
import 'package:student_calendar_app/core/models/notification.dart';

abstract class NotificationsRepository {
  Future<PaginatedResult<Notification>> getNotifications({int? page});
}
