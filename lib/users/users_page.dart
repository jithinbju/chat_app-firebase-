import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';
import 'user_tile.dart';
import '../chat/chat_page.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  final FirestoreService _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: StreamBuilder<List<AppUser>>(
        stream: _firestore.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return UserTile(
                user: user,
                onTap: () {
                  // ✅ Open chat directly (NO SnackBar)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        otherUserId: user.uid,
                        otherUserEmail: user.email,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
