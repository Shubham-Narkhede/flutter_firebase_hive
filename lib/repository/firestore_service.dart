import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/entity_user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addRecord(EntityUser users) async {
    try {
      // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      // Reference storageRef =
      //     FirebaseStorage.instance.ref().child('users/$fileName');

      // UploadTask uploadTask = storageRef.putFile(immage);
      // TaskSnapshot taskSnapshot = await uploadTask;
      // String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await _db.collection('users').add({
        'name': users.name,
        'email': users.email,
        'mobile': users.mobile,
        'address': users.address,
        'image': "imageUrl",
      });
    } catch (e) {
      throw Exception("Error adding record: $e");
    }
  }

  Stream<List<Map<String, dynamic>>> getRecords() {
    return _db.collection('users').snapshots().map(
      (querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'email': doc['email'],
            'mobile': doc['mobile'],
            'address': doc['address'],
            'image': doc['image'],
          };
        }).toList();
      },
    );
  }
}
