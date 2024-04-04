import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/core.dart';
import 'package:student_calendar_app/pages/class/class_binding.dart';
import 'package:student_calendar_app/pages/class/class_view.dart';
import 'package:student_calendar_app/pages/login/login_binding.dart';
import 'package:student_calendar_app/pages/login/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_calendar_app/pages/main/main_binding.dart';
import 'package:student_calendar_app/pages/main/main_view.dart';
import 'package:student_calendar_app/pages/profile/profile_binding.dart';
import 'package:student_calendar_app/pages/profile/profile_view.dart';
import 'package:student_calendar_app/pages/signup/signup_binding.dart';
import 'package:student_calendar_app/pages/signup/signup_view.dart';
import 'package:student_calendar_app/pages/task/task_binding.dart';
import 'package:student_calendar_app/pages/task/task_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Student Calendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent, brightness: Brightness.dark),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/login',
            page: () => LoginPage(),
            binding: LoginPageBinding()),
        GetPage(
            name: '/signup',
            page: () => SignUpPage(),
            binding: SignupBinding()),
        GetPage(name: '/', page: () => MainPage(), binding: MainPageBinding()),
        GetPage(
            name: '/profile',
            page: () => ProfilePage(),
            binding: ProfilePageBinding(),
            transition: Transition.cupertino),
        GetPage(
            name: '/classes/:classId',
            page: () => ClassPage(),
            binding: ClassPageBinding(),
            transition: Transition.cupertino),
        GetPage(
            name: '/classes/:classId/tasks/:taskId',
            page: () => TaskPage(),
            binding: TaskPageBinding(),
            fullscreenDialog: true,
            transition: Transition.downToUp)
      ],
    );
  }
}
