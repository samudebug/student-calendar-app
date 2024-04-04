import 'package:student_calendar_app/core/models/student.dart';

class Task {
  String id;
  String name;
  String notes;
  DateTime deliverDate;
  String createdBy;
  String classId;
  DateTime createdAt;
  DateTime updatedAt;
  Student? student;

  Task(
      {required this.id,
      required this.name,
      required this.notes,
      required this.deliverDate,
      required this.createdBy,
      required this.classId,
      required this.createdAt,
      required this.updatedAt,
      this.student});

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        notes = json['notes'],
        deliverDate = DateTime.parse(json['deliverDate']),
        createdBy = json['createdBy'],
        classId = json['classId'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']),
        student =
            json['student'] != null ? Student.fromJson(json['student']) : null;
}
