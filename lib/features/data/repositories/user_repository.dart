
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_dvp/features/data/models/user_model.dart';

class UserRepository {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel userData) async {
    await _usersCollection.add(userData.toJson());
  }

  Future<List<UserModel>> fetchUsers() async {
    QuerySnapshot snapshot = await _usersCollection.get();
    return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
  }

  Future<void> updateUser(UserModel userData) async {
    await _usersCollection.doc(userData.id).update(userData.toJson());
  }

  Future<void> deleteUser(String id) async {
    await _usersCollection.doc(id).delete();
  }
}