class LocalUser {
  String id;
  String name;
  String email;
  String photoURL;

  LocalUser({required this.id, required this.name, required this.email, required this.photoURL});

  @override
  String toString() {
    
    return "User ID: $id Name: $name";
  }
}