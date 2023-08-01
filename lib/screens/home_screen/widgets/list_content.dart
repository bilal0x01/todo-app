import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen/widgets/app_text_field.dart';
import 'package:todo_app/screens/home_screen/widgets/expanded_fab.dart';
import 'package:todo_app/screens/home_screen/widgets/tasks_dashboard.dart';
import 'package:todo_app/services/database/tasks_provider.dart';
import 'package:todo_app/theme/spaces.dart';
import 'package:todo_app/utils/show_bottomsheet.dart';

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
    final listTasksRef = listsData[selectedList]['docReference'];

    void submitData() {
      Navigator.pop(context);
      if (taskNameController.text.isEmpty) {
        return null;
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
      child: Container(
        width: double.infinity,
        child: Stack(children: [
          TasksDashboard(listTasksReference: listTasksRef),
          Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              children: [
                ExpandedFab(
                    listTasksRef: listTasksRef, reduceIndex: reduceIndex),
                smallVertSpace,
                IconButton(
                  onPressed: () {
                    showInputBottomSheet(
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
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
