import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FCMService {
  final _messaging = FirebaseMessaging.instance;
  final _db = FirebaseFirestore.instance;

  Future<void> init() async {
    // Ask permission
    await _messaging.requestPermission();

    final token = await _messaging.getToken();
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null && token != null) {
      await _db.collection('users').doc(uid).update({
        'fcmToken': token,
      });
    }

    // Token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      if (uid != null) {
        _db.collection('users').doc(uid).update({
          'fcmToken': newToken,
        });
      }
    });
  }
}
