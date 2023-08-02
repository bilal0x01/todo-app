import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import '../../static/constants.dart';

class ListsProvider {
  static final firestore = FirebaseFirestore.instance;
  static const listsCollection = AppConstants.listsCollection;

  static Future<void> createList(String listName) async {
    try {
      final payload = {
        'listName': listName,
      };
      await firestore
          .collection(listsCollection)
          .doc(DateTime.now().microsecondsSinceEpoch.toString())
          .set(payload);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<void> updateList(
    DocumentReference listReference,
    String listName,
  ) async {
    try {
      final payload = {
        'listName': listName,
      };
      await listReference.update(payload);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<void> deleteList(DocumentReference listReference) async {
    try {
      final tasksCollectionRef = listReference.collection('tasks');
      final tasksQuerySnapshot = await tasksCollectionRef.get();
      for (var taskDocument in tasksQuerySnapshot.docs) {
        taskDocument.reference.delete();
      }
      await listReference.delete();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Stream<List<Map<String, dynamic>>> getData() {
    return firestore.collection(listsCollection).snapshots().map(
          (querySnapshot) => querySnapshot.docs.map(
            (list) {
              DocumentReference listReference =
                  firestore.collection(listsCollection).doc(list.id);
              final listData = list.data();
              return {'docReference': listReference, 'docData': listData};
            },
          ).toList(),
        );
  }
}
