import 'package:get/get.dart';
import 'package:student_calendar_app/core/services/auth_service.dart';

class ProfilePageController extends GetxController {
  final imgUrl = ''.obs;
  final userName = ''.obs;
  final email = ''.obs;
  final authService = Get.find<AuthService>();


  ProfilePageController() {
    imgUrl.value = authService.user?.photoURL ?? '';
    userName.value = authService.user?.displayName ?? '';
    email.value = authService.user?.email ?? '';
  }

  signOut() async{
    await authService.signOut();
  }

  back() {
    Get.back();
  }
}
