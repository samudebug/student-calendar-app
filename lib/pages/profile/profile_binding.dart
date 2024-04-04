import 'package:get/get.dart';
import 'package:student_calendar_app/pages/profile/profile_controller.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilePageController());
  }
}