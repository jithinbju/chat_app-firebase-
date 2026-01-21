import 'package:chat_app_firebase/home/home_page.dart';
import 'package:chat_app_firebase/services/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'login_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _fcmInitialized = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          // 🔔 INIT FCM ONLY ONCE AFTER LOGIN
          if (!_fcmInitialized) {
            _fcmInitialized = true;

            // Init FCM service
            FCMService().init();

            // 🔥 DEBUG: print token (TEMPORARY)
            FirebaseMessaging.instance.getToken().then((token) {
              debugPrint("🔥 FCM TOKEN: $token");
            });
          }

          return const HomePage();
        } else {
          _fcmInitialized = false;
          return const LoginPage();
        }
      },
    );
  }
}
