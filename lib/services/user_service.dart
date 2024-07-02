//user_service

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new user
  Future<void> createUser(User user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  // Read user by ID
  Future<User?> getUser(String id) async {
    DocumentSnapshot doc = await _db.collection('users').doc(id).get();
    if (doc.exists) {
      return User.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Update user by ID
  Future<void> updateUser(User user) async {
    await _db.collection('users').doc(user.id).update(user.toMap());
  }

  // Delete user by ID
  Future<void> deleteUser(String id) async {
    await _db.collection('users').doc(id).delete();
  }

  // Read all users
  Stream<List<User>> getUsers() {
    return _db.collection('users').snapshots().map((snapshot) {
      return snapshot.docs
          .map(
              (doc) => User.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
