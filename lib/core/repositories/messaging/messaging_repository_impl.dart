import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:student_calendar_app/core/repositories/messaging/messaging_repository.dart';

class MessagingRepositoryImpl implements MessagingRepository {
  FirebaseMessaging instance = FirebaseMessaging.instance;
  
  @override
  Stream<String> get onTokenRefresh => instance.onTokenRefresh;

  @override  
  Stream<RemoteMessage> get onForegroundMessage => FirebaseMessaging.onMessage;

  @override
  void requestPermission() async {
    
    await instance.requestPermission(provisional: true);
    
  }

  @override
  Future<String?> getToken() async{
    return instance.getToken();
  }

  @override
  void subscribeToTopic({required String name}) {
    instance.subscribeToTopic(name);
  }

}