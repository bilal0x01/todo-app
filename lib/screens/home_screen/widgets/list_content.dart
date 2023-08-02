import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'app_text_field.dart';
import 'expanded_fab.dart';
import 'tasks_dashboard.dart';
import '../../../services/database/tasks_provider.dart';
import '../../../theme/spaces.dart';
import '../../../utils/show_textfield_sheet.dart';

class ListContent extends StatelessWidget {
  ListContent({
    super.key,
    required this.listsData,
    required this.selectedList,
    required this.reduceIndex,
  });

  final List<Map<String, dynamic>> listsData;
  final int selectedList;
  final VoidCallback reduceIndex;
  final taskNameController = TextEditingController();
  final taskDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listTasksRef =
        listsData[selectedList]['docReference'] as DocumentReference;

    void submitData() {
      Navigator.pop(context);
      if (taskNameController.text.isEmpty) {
        return;
      }
      TasksProvider.createTask(
        listTasksRef,
        taskNameController.text,
        taskDetailsController.text,
      );
      taskNameController.clear();
      taskDetailsController.clear();
    }

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Stack(children: [
          TasksDashboard(listTasksReference: listTasksRef),
          Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              children: [
                ExpandedFab(
                  listTasksRef: listTasksRef,
                  reduceIndex: reduceIndex,
                ),
                smallVertSpace,
                IconButton(
                  onPressed: () {
                    showTextfieldSheet(
                      context: context,
                      sheetTitle: "Create new task",
                      sheetWidgetList: [
                        for (var i = 0; i < 2; i++)
                          AppTextField(
                            editCompleteFunction: i == 1 ? submitData : null,
                            fieldController: i == 0
                                ? taskNameController
                                : taskDetailsController,
                            fieldHintText: i == 0
                                ? "Enter task title"
                                : "Enter task details",
                            nextIconKeyboard: i == 0 ? true : false,
                          ),
                      ],
                      sheetSubmitAction: submitData,
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
