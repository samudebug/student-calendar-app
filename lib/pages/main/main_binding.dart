import 'package:get/get.dart';
import 'package:student_calendar_app/pages/main/main_controller.dart';
import 'package:student_calendar_app/pages/main/widgets/classes/classes_controller.dart';
import 'package:student_calendar_app/pages/main/widgets/feed/feed_controller.dart';
import 'package:student_calendar_app/widgets/user_info/user_info_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
    Get.lazyPut(() => UserInfoController());
    Get.lazyPut(() => FeedController());
    Get.lazyPut(() => ClassesController());
  }
}