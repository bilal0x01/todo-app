// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen/widgets/app_text_field.dart';
import 'package:todo_app/services/database/tasks_provider.dart';
import 'package:todo_app/theme/app_colors.dart';
import 'package:todo_app/theme/spaces.dart';
import 'package:todo_app/utils/show_textfield_sheet.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.listTasksReference,
    required this.taskData,
  });

//mapstringdynamic
  final Map<String, dynamic> taskData;
  final listTasksReference;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final taskNameController = TextEditingController();
  final taskDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void Function()? submitData(taskRef) {
      Navigator.pop(context);

      TasksProvider.updateTask(
        taskRef,
        widget.listTasksReference,
        taskNameController.text.isEmpty ? null : taskNameController.text,
        taskDetailsController.text.isEmpty ? null : taskDetailsController.text,
      );
      taskNameController.clear();
      taskDetailsController.clear();
      return null;
    }

    return Dismissible(
      background: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.delete_forever,
            color: AppColors.errorColor,
            size: 28,
          ),
          bigHorzSpace
        ],
      ),
      direction: DismissDirection.endToStart,
      key: ValueKey(
        widget.taskData['docReference'].id.toString(),
      ),
      onDismissed: (_) => TasksProvider.deleteTask(
        widget.taskData['docReference'],
        widget.listTasksReference,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.subtleColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: () => showTextfieldSheet(
            context: context,
            sheetTitle: "Edit task",
            sheetWidgetList: [
              for (var i = 0; i < 2; i++)
                AppTextField(
                  editCompleteFunction: i == 1
                      ? () => (submitData(widget.taskData['docReference']),)
                      : null,
                  fieldController:
                      i == 0 ? taskNameController : taskDetailsController,
                  fieldHintText:
                      i == 0 ? "Enter task title" : "Enter task details",
                  nextIconKeyboard: i == 0 ? true : false,
                ),
            ],
            sheetSubmitAction: () =>
                submitData(widget.taskData['docReference']),
          ),
          minVerticalPadding: 0,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
          horizontalTitleGap: 8,
          leading: IconButton(
            icon: widget.taskData['docData']['hasCompleted'] as bool
                ? const Icon(Icons.check_box_rounded)
                : const Icon(Icons.check_box_outline_blank),
            color: AppColors.textColor,
            onPressed: () {
              setState(
                () {
                  TasksProvider.updateTask(
                    (widget.taskData['docReference']),
                    widget.listTasksReference,
                    null,
                    null,
                    taskDone: !widget.taskData['docData']['hasCompleted'],
                  );
                },
              );
            },
          ),
          title: Text(
            widget.taskData['docData']['taskName'],
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle:
              (widget.taskData['docData']['taskDetails'] as String).isEmpty
                  ? null
                  : Text(
                      widget.taskData['docData']['taskDetails'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFCCCCCC),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
        ),
      ),
    );
  }
}
