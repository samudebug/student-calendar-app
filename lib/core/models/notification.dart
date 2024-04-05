class Notification {
  String id;
  String title;
  String body;
  String data;
  String classId;
  DateTime createdAt;
  DateTime updatedAt;

  Notification(
      {required this.id,
      required this.title,
      required this.body,
      required this.data,
      required this.classId,
      required this.createdAt,
      required this.updatedAt});

  Notification.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        body = json['body'],
        data = json['data'],
        classId = json['classId'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}
