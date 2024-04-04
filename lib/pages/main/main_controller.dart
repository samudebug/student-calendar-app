import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/widgets/create_class/create_class_view.dart';


class MainPageController extends GetxController {
  final selectedPage = 0.obs;
  final fabKey = GlobalKey<ExpandableFabState>();

  changePage(int index) {
    selectedPage.value = index;
  }

  openAddClass() {
    fabKey.currentState?.toggle();
    Get.bottomSheet(CreateClassDialog(), backgroundColor: Get.theme.colorScheme.background);
  }
}