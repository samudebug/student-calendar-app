class Student {
  String id;
  String userId;
  String name;
  String photoUrl;

  Student(
      {required this.id,
      required this.userId,
      required this.name,
      required this.photoUrl});

  Student.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        name = json['name'],
        photoUrl = json['photoUrl'];
}
