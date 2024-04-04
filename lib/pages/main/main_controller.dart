import 'package:get/get.dart';


class MainPageController extends GetxController {
  final selectedPage = 0.obs;

  changePage(int index) {
    selectedPage.value = index;
  }

  openAddClass() {
    
  }
}