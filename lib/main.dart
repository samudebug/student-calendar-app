import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_calendar_app/core/core.dart';
import 'package:student_calendar_app/core/services/auth_service.dart';
import 'package:student_calendar_app/pages/class/class_binding.dart';
import 'package:student_calendar_app/pages/class/class_view.dart';
import 'package:student_calendar_app/pages/login/login_binding.dart';
import 'package:student_calendar_app/pages/login/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student_calendar_app/pages/main/main_binding.dart';
import 'package:student_calendar_app/pages/main/main_view.dart';
import 'package:student_calendar_app/pages/notifications/notifications_binding.dart';
import 'package:student_calendar_app/pages/notifications/notifications_view.dart';
import 'package:student_calendar_app/pages/profile/profile_binding.dart';
import 'package:student_calendar_app/pages/profile/profile_view.dart';
import 'package:student_calendar_app/pages/signup/signup_binding.dart';
import 'package:student_calendar_app/pages/signup/signup_view.dart';
import 'package:student_calendar_app/pages/students/students_binding.dart';
import 'package:student_calendar_app/pages/students/students_view.dart';
import 'package:student_calendar_app/pages/task/task_binding.dart';
import 'package:student_calendar_app/pages/task/task_view.dart';
import 'package:student_calendar_app/pages/task_form/task_form_binding.dart';
import 'package:student_calendar_app/pages/task_form/task_form_view.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'student_calendar_notifications',
    'Student Calendar Notifications',
    channelDescription: 'Student Calendar Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      0, message.data['title'], message.data['body'], notificationDetails,
      payload: message.data['data']);
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
      onInit: () {
        Get.find<AuthService>().checkUserLoggedIn();
      },

      getPages: [
        GetPage(
            name: '/login',
            page: () => LoginPage(),
            binding: LoginPageBinding()),
        GetPage(
            name: '/signup',
            page: () => SignUpPage(),
            binding: SignupBinding()),
        GetPage(name: '/', page: () => MainPage(), binding: MainPageBinding(), ),
        GetPage(
            name: '/notifications',
            page: () => NotificationsPage(),
            binding: NotificationsBinding()),
        GetPage(
            name: '/profile',
            page: () => ProfilePage(),
            binding: ProfilePageBinding(),
            transition: Transition.cupertino),
        GetPage(
            name: '/classes/:classId',
            page: () => ClassPage(),
            binding: ClassPageBinding(),
            preventDuplicates: true,
            transition: Transition.cupertino),
        GetPage(
            name: '/classes/:classId/students',
            page: () => StudentsPage(),
            binding: StudentsBinding(),
            transition: Transition.downToUp,
            fullscreenDialog: true),
        GetPage(
            name: '/classes/:classId/tasks/new',
            page: () => TaskForm(),
            binding: TaskFormBinding(),
            fullscreenDialog: true,
            transition: Transition.downToUp),
        GetPage(
            name: '/classes/:classId/tasks/:taskId',
            page: () => TaskPage(),
            binding: TaskPageBinding(),
            fullscreenDialog: true,
            transition: Transition.downToUp),
        GetPage(
            name: '/classes/:classId/tasks/:taskId/edit',
            page: () => TaskForm(),
            binding: TaskFormBinding(),
            fullscreenDialog: true,
            transition: Transition.cupertino)
      ],
    );
  }
}
