import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/profile/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.find<ProfilePageController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => controller.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Obx(() => CircleAvatar(
                      backgroundColor: context.theme.colorScheme.primary,
                      radius: 40,
                      backgroundImage: controller.imgUrl.value.isEmpty
                          ? null
                          : NetworkImage(controller.imgUrl.value),
                      child: controller.imgUrl.value.isEmpty
                          ? Text(controller.userName.value[0].toUpperCase())
                          : null,
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Obx(() => Text(
                    controller.userName.value,
                    style: context.theme.textTheme.displayLarge,
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Obx(() => Text(
                    controller.email.value,
                    style: context.theme.textTheme.titleMedium,
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                child: Text("Logout"),
                onPressed: () => controller.signOut(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.colorScheme.error,
                    foregroundColor: context.theme.colorScheme.onError),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
