import 'package:get/get.dart';
import 'package:student_calendar_app/pages/task/task_controller.dart';

class TaskPageBinding extends Bindings {
  @override
  void dependencies() {  
    Get.create(() => TaskPageController());
  }
}