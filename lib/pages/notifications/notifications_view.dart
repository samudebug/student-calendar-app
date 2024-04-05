import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/notifications/notifications_controller.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});
  final controller = Get.find<NotificationsPageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => controller.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async => controller.refresh(),
                child: ListView.builder(
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) => ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text(controller.notifications[index].title),
                          subtitle: Text(controller.notifications[index].body),
                        )),
              ),
      ),
    );
  }
}
