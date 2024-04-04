import 'package:get/get.dart';
import 'package:student_calendar_app/pages/class/class_controller.dart';
import 'package:student_calendar_app/widgets/user_info/user_info_controller.dart';

class ClassPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoController());
    Get.create(() => ClassPageController());
  }
}