import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/main/main_controller.dart';
import 'package:student_calendar_app/pages/main/widgets/classes/classes_view.dart';
import 'package:student_calendar_app/pages/main/widgets/feed/feed_view.dart';
import 'package:student_calendar_app/pages/main/widgets/user_info/user_info.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final controller = Get.find<MainPageController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Calendar",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: UserInfo(),
          )
        ],
      ),
      bottomNavigationBar: Obx(() => NavigationBar(
            selectedIndex: controller.selectedPage.value,
            onDestinationSelected: controller.changePage,
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.list_rounded), label: 'Feed'),
              NavigationDestination(icon: Icon(Icons.people), label: 'Classes'),
            ],
          )),
      body: Obx(() => <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: FeedView(),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: ClassesView(),
            ),
          ][controller.selectedPage.value]),
    ));
  }
}
