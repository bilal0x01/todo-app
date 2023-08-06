import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static Future<UserCredential?> register({
    required String password,
    required String email,
    required String name,
    required Function(String error) storeError,
  }) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await user.user!.sendEmailVerification();

      final data = {
        'name': name,
        'email': email,
        'id': user.user!.uid,
      };

      await _firestore.collection('users').doc(user.user!.uid).set(data);

      return user;
    } catch (e) {
      debugPrint(e.toString());
      storeError(e.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
    required Function(String error) storeError,
  }) async {
    try {
      final creds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final raw =
          await _firestore.collection('users').doc(creds.user!.uid).get();

      final data = raw.data();

      return data;
    } catch (e) {
      debugPrint(e.toString());
      storeError(e.toString());
      return null;
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }
}
