import 'package:chat_app_firebase/services/auth_service.dart';
import 'package:chat_app_firebase/users/users_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
            },
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Start Chat"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UsersPage()),
            );
          },
        ),
      ),
    );
  }
}
