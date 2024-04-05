import 'package:get/get.dart';
import 'package:student_calendar_app/pages/notifications/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => NotificationsPageController());
  }
}