import 'package:get/get.dart';
import 'package:student_calendar_app/pages/login/login_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPageController());
  }
}