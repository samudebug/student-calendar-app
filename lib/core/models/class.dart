class Class {
  String id;
  String name;
  String code;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;

  Class(
      {required this.id,
      required this.name,
      required this.code,
      required this.createdBy,
      required this.createdAt,
      required this.updatedAt});

  Class.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        code = json['code'],
        createdBy = json['createdBy'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);
}
