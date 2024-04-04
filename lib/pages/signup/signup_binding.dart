import 'package:get/get.dart';
import 'package:student_calendar_app/pages/signup/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}