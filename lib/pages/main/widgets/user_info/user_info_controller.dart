import 'package:get/get.dart';
import 'package:student_calendar_app/core/services/auth_service.dart';

class UserInfoController extends GetxController {
  final imgUrl = ''.obs;
  final userName = ''.obs;
  final authService = Get.find<AuthService>();
  

  UserInfoController() {
    authService.checkUserLoggedIn();
    imgUrl.value = authService.user?.photoURL ?? '';
    userName.value = authService.user?.displayName ?? '';
  }
  
  openProfile() {
    Get.toNamed('/profile', );
  }
}