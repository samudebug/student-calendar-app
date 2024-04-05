import 'package:firebase_messaging/firebase_messaging.dart';

abstract class MessagingRepository {
  Stream<String> get onTokenRefresh;
  Stream<RemoteMessage> get onForegroundMessage;
  void requestPermission();
  Future<String?> getToken();
  void subscribeToTopic({required String name});

}