import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/main/widgets/user_info/user_info_controller.dart';

class UserInfo extends StatelessWidget {
  UserInfo({super.key});
  final controller = Get.find<UserInfoController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () => controller.openProfile(),
          child: CircleAvatar(
            backgroundColor: Get.theme.colorScheme.primary,
            backgroundImage: controller.imgUrl.value.isEmpty
                ? null
                : NetworkImage(controller.imgUrl.value),
            child: controller.imgUrl.value.isEmpty
                ? Text(controller.userName.value.isEmpty
                    ? ''
                    : controller.userName.value[0].toUpperCase())
                : null,
          ),
        ));
  }
}
