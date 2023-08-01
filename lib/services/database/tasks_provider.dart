import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/static/constants.dart';

class TasksProvider {
  static final firestore = FirebaseFirestore.instance;
  static const listsCollection = AppConstants.listsCollection;
  static const tasksCollection = AppConstants.tasksCollection;

  static Future<void> createTask(DocumentReference parentListReference,
      String taskName, String taskDetails) async {
    try {
      final payload = {
        'taskName': taskName,
        'taskDetails': taskDetails,
        'hasCompleted': false
      };
      await firestore
          .collection(listsCollection)
          .doc(parentListReference.id)
          .collection(tasksCollection)
          .doc(DateTime.now().microsecondsSinceEpoch.toString())
          .set(payload);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // static Future<void> updateList(
  //     DocumentReference listReference, String listName) async {
  //   try {
  //     final payload = {
  //       'listName': listName,
  //     };
  //     await listReference.update(payload);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     rethrow;
  //   }
  // }

  // static Future<void> deleteList(DocumentReference listReference) async {
  //   try {
  //     final tasksCollectionRef = listReference.collection('tasks');
  //     final tasksQuerySnapshot = await tasksCollectionRef.get();
  //     tasksQuerySnapshot.docs.forEach((taskDocument) {
  //       taskDocument.reference.delete();
  //     });
  //     await listReference.delete();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     rethrow;
  //   }
  // }

  static Stream<List<Map<String, dynamic>>> getData(
      DocumentReference parentListReference) {
    return firestore
        .collection(listsCollection)
        .doc(parentListReference.id)
        .collection(tasksCollection)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs.map(
            (task) {
              DocumentReference taskReference =
                  firestore.collection(tasksCollection).doc(task.id);
              final taskData = task.data();
              return {'docReference': taskReference, 'docData': taskData};
            },
          ).toList(),
        );
  }
}
