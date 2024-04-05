import 'package:get/get.dart';
import 'package:student_calendar_app/core/models/class.dart';
import 'package:student_calendar_app/core/models/student.dart';
import 'package:student_calendar_app/core/repositories/classes/classes_repository.dart';
import 'package:student_calendar_app/core/services/auth_service.dart';

class StudentsPageController extends GetxController {
  final repo = Get.find<ClassesRepository>();
  final authService = Get.find<AuthService>();
  final currentClass = Rx<Class?>(null);
  final students = <Student>[].obs;
  final loading = true.obs;
  final canDelete = false.obs;
  late final userId = authService.user.uid;

  StudentsPageController() {
    getData();
  }

  getData() async {
    final classId = Get.parameters['classId'];
    if (classId == null) return;
    currentClass.value = await repo.getClass(id: classId);
    students.clear();
    students.addAll(currentClass.value!.students ?? []);
    canDelete.value = currentClass.value!.createdBy == authService.user.uid;
    loading.value = false;
  }

  removeStudent(Student student) {
    Get.defaultDialog(
        title: "Are you sure you want to remove this student?",
        middleText: "They will have to join again if necessary",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () async {
          await repo.removeStudent(
              classId: currentClass.value!.id, studentId: student.userId);
          getData();
          Get.back();
        });
  }
}
