import 'package:student_calendar_app/core/models/models.dart';

abstract class ClassesRepository {
  Future<PaginatedResult<Class>> getClasses({int? page});
  Future<Class> getClass({required String id});
  Future<Class> createClass({required String name});
  Future<Class> joinClass({required String code});
  Future<void> removeStudent({required String classId, required String studentId});
}