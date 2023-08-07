import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../static/constants.dart';

class TasksProvider {
  static final firestore = FirebaseFirestore.instance;
  static const listsCollection = AppConstants.listsCollection;
  static const tasksCollection = AppConstants.tasksCollection;

  static Future<void> createTask(
    DocumentReference parentListReference,
    String taskName,
    String taskDetails,
  ) async {
    try {
      final payload = {
        'taskName': taskName,
        'taskDetails': taskDetails,
        'hasCompleted': false,
        'imageUrl': '',
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

  static Future<void> updateTask(
    DocumentReference taskReference,
    DocumentReference parentListReference, {
    String? taskName,
    String? taskDetails,
    String? imageUrl,
    bool? taskDone,
  }) async {
    final taskData = firestore
        .collection(listsCollection)
        .doc(parentListReference.id)
        .collection(tasksCollection)
        .doc(taskReference.id);
    final existingTaskSnapshot = await taskData.get();
    final existingTaskName = existingTaskSnapshot.data()!['taskName'];
    final existingTaskDetails = existingTaskSnapshot.data()!['taskDetails'];
    final existingTaskImageUrl = existingTaskSnapshot.data()!['imageUrl'];
    final existingTaskStatus = existingTaskSnapshot.data()!['hasCompleted'];
    try {
      final payload = {
        'taskName': taskName ?? existingTaskName,
        'taskDetails': taskDetails ?? existingTaskDetails,
        'hasCompleted': taskDone ?? existingTaskStatus,
        'imageUrl': imageUrl ?? existingTaskImageUrl,
      };
      await taskData.update(payload);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<void> deleteTask(
    DocumentReference taskReference,
    DocumentReference parentListReference,
  ) async {
    try {
      await firestore
          .collection(listsCollection)
          .doc(parentListReference.id)
          .collection(tasksCollection)
          .doc(taskReference.id)
          .delete();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

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
