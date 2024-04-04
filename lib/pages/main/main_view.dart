import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/pages/main/main_controller.dart';
import 'package:student_calendar_app/pages/main/widgets/classes/classes_view.dart';
import 'package:student_calendar_app/pages/main/widgets/feed/feed_view.dart';
import 'package:student_calendar_app/widgets/default_app_bar.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final controller = Get.find<MainPageController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => Scaffold(
              appBar: DefaultAppBar(),
              floatingActionButtonLocation: ExpandableFab.location,
              floatingActionButton: controller.selectedPage.value == 1 ? ExpandableFab(
                
                type: ExpandableFabType.up,
                openButtonBuilder: DefaultFloatingActionButtonBuilder(
                  heroTag: null,
                  child: const Icon(Icons.add),
                  fabSize: ExpandableFabSize.regular,
                  foregroundColor: context.theme.colorScheme.secondary,
                  backgroundColor: context.theme.colorScheme.onSecondary,
                  shape: const CircleBorder(),
                ),
                closeButtonBuilder: DefaultFloatingActionButtonBuilder(
                  heroTag:null,
                  child: const Icon(Icons.close),
                  fabSize: ExpandableFabSize.regular,
                  foregroundColor: context.theme.colorScheme.secondary,
                  backgroundColor: context.theme.colorScheme.onSecondary,
                  shape: const CircleBorder(),
                ),
                children: [
                  FloatingActionButton.extended(
                    heroTag: "Add_Class_Button",
                    label: Text("Add Class"),
                    icon: Icon(Icons.add),
                    onPressed: () {},
                  ),
                  FloatingActionButton.extended(
                    heroTag: "Join_Class_Button",
                    label: Text("Join Class"),
                    icon: Icon(Icons.person_add),
                    onPressed: () {},
                  )
                ],
              ) : null,
              bottomNavigationBar: NavigationBar(
                selectedIndex: controller.selectedPage.value,
                onDestinationSelected: controller.changePage,
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.list_rounded), label: 'Feed'),
                  NavigationDestination(
                      icon: Icon(Icons.people), label: 'Classes'),
                ],
              ),
              body: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FeedView(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClassesView(),
                ),
              ][controller.selectedPage.value],
            )));
  }
}


