import 'package:get/get.dart';
import 'package:student_calendar_app/core/repositories/auth/auth_repository.dart';
import 'package:student_calendar_app/core/repositories/auth/auth_repository_impl.dart';
import 'package:student_calendar_app/core/repositories/classes/classes_repository.dart';
import 'package:student_calendar_app/core/repositories/classes/classes_repository_impl.dart';
import 'package:student_calendar_app/core/repositories/feed/feed_repository.dart';
import 'package:student_calendar_app/core/repositories/feed/feed_repository_impl.dart';
import 'package:student_calendar_app/core/repositories/tasks/tasks_repository.dart';
import 'package:student_calendar_app/core/repositories/tasks/tasks_repository_impl.dart';
import 'package:student_calendar_app/core/services/auth_service.dart';

initRepositories() async {
  await Get.putAsync<AuthRepository>(() async => AuthRepositoryFirebase());
  await Get.putAsync<FeedRepository>(() async => FeedRepositoryImpl());
  await Get.putAsync<ClassesRepository>(() async => ClassesRepositoryImpl());
  await Get.putAsync<TasksRepository>(() async => TasksRepositoryImpl());
}

initServices() async {
  await Get.putAsync(() async => AuthService());
}

init() async {
  await initRepositories();
  await initServices();
}
