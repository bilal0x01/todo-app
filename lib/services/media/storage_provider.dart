import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  static final storage = FirebaseStorage.instance;

  static Future<String> uploadImage(File file, String fileName) async {
    final imageRef = storage.ref("taskImages/$fileName");
    try {
      final uploadTaskImg = imageRef.putFile(file);
      final snapshot = await uploadTaskImg.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteImage(String imageUrl) async {
    try {
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
    }
  }
}
