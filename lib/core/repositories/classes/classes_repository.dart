import 'package:student_calendar_app/core/models/models.dart';

abstract class ClassesRepository {
  Future<PaginatedResult<Class>> getClasses({int? page});
  Future<Class> getClass({required String id});
  
}