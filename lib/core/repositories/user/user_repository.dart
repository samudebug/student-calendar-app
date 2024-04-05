abstract class UserRepository {
  Future<void> updateUser({required String fcmToken, required String name});
}