import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'app_text_field.dart';
import '../../../services/database/lists_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/show_textfield_sheet.dart';

class ExpandedFab extends StatelessWidget {
  ExpandedFab({
    super.key,
    required this.listTasksRef,
    required this.reduceIndex,
  });

  final DocumentReference listTasksRef;
  final VoidCallback reduceIndex;
  final listTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void submitData() {
      Navigator.pop(context);
      if (listTitleController.text.isEmpty) {
        return;
      }
      ListsProvider.updateList(listTasksRef, listTitleController.text);
      listTitleController.clear();
    }

    return SpeedDial(
      icon: Icons.more_vert,
      activeIcon: Icons.close,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      overlayColor: Colors.black,
      overlayOpacity: 0.8,
      children: [
        SpeedDialChild(
            labelStyle: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
            ),
            label: "Rename list",
            child: const Icon(Icons.edit),
            onTap: () {
              showTextfieldSheet(
                context: context,
                sheetTitle: "Rename your list",
                sheetWidgetList: [
                  AppTextField(
                    editCompleteFunction: submitData,
                    fieldController: listTitleController,
                    fieldHintText: "Enter new list title",
                    nextIconKeyboard: false,
                  )
                ],
                sheetSubmitAction: submitData,
              );
            }),
        SpeedDialChild(
            labelStyle: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
            ),
            label: "Delete list",
            child: const Icon(Icons.delete),
            onTap: () {
              ListsProvider.deleteList(listTasksRef);
              reduceIndex();
            }),
      ],
    );
  }
}
