import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';
import '../models/chat_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ======================
  /// USERS (DISCOVERY)
  /// ======================
  Stream<List<AppUser>> getUsers() {
    return _db.collection('users').snapshots().map((snapshot) {
      final currentUid = _auth.currentUser?.uid;

      return snapshot.docs
          .map((doc) => AppUser.fromMap(doc.data()))
          .where((u) => currentUid == null || u.uid != currentUid)
          .toList();
    });
  }

  /// ======================
  /// GET USER BY UID
  /// ======================
  Future<AppUser> getUserById(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return AppUser.fromMap(doc.data()!);
  }

  /// ======================
  /// CHAT ID (DETERMINISTIC)
  /// ======================
  String getChatId(String uid1, String uid2) {
    return uid1.compareTo(uid2) < 0
        ? '${uid1}_$uid2'
        : '${uid2}_$uid1';
  }

  /// ======================
  /// CREATE CHAT (NO READ)
  /// ======================
  Future<String> createChat(String otherUserId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final chatId = getChatId(user.uid, otherUserId);

    await _db.collection('chats').doc(chatId).set({
      'participants': [user.uid, otherUserId],
      'lastMessage': '',
      'lastMessageTime': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return chatId;
  }

  /// ======================
  /// SEND MESSAGE
  /// ======================
  Future<void> sendMessage(String chatId, String text) async {
    final user = _auth.currentUser;
    if (user == null || text.trim().isEmpty) return;

    final now = FieldValue.serverTimestamp();

    await _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': user.uid,
      'text': text.trim(),
      'timestamp': now,
    });

    await _db.collection('chats').doc(chatId).update({
      'lastMessage': text.trim(),
      'lastMessageTime': now,
    });
  }

  /// ======================
  /// STREAM MESSAGES
  /// ======================
  Stream<List<Message>> getMessages(String chatId) {
  return _db
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .orderBy('timestamp', descending: false)
      .snapshots()
      .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
        return snapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
              return Message.fromMap(doc.data());
            })
            .toList();
      });
}


  /// ======================
  /// CHAT LIST (RECENT CHATS)
  /// ======================
  Stream<List<Chat>> getUserChats() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return Stream.value([]);
    }

    return _db
        .collection('chats')
        .where('participants', arrayContains: uid)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Chat.fromDoc(doc.id, doc.data()))
          .toList();
    });
  }
}
