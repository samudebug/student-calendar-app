import 'package:get/get.dart';
import 'package:student_calendar_app/pages/task_form/task_form_controller.dart';

class TaskFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => TaskFormController());
  }
}
