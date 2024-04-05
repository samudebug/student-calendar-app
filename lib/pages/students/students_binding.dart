import 'package:get/get.dart';
import 'package:student_calendar_app/pages/students/students_controller.dart';

class StudentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => StudentsPageController());
  }
}