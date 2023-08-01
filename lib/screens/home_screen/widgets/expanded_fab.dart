import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo_app/services/database/lists_provider.dart';
import 'package:todo_app/theme/app_colors.dart';
import 'package:todo_app/utils/show_bottomsheet.dart';

class ExpandedFab extends StatelessWidget {
  const ExpandedFab({
    super.key,
    required this.listTasksRef,
    required this.reduceIndex,
  });

  final listTasksRef;
  final VoidCallback reduceIndex;

  @override
  Widget build(BuildContext context) {
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
            labelStyle: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
            ),
            label: "Rename list",
            child: Icon(Icons.edit),
            onTap: () {
              showInputBottomSheet(
                  context: context,
                  sheetTitle: "Rename your list",
                  sheetWidgetList: [],
                  sheetSubmitAction: () {
                    ListsProvider.updateList(listTasksRef, "bills");
                  });
            }),
        SpeedDialChild(
            labelStyle: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 14,
            ),
            label: "Delete list",
            child: Icon(Icons.delete),
            onTap: () {
              ListsProvider.deleteList(listTasksRef);
              reduceIndex();
            }),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:todo_app/services/database/lists_provider.dart';
// import 'package:todo_app/theme/app_colors.dart';
// import 'package:todo_app/widgets/design/app_bottom_sheet.dart';

// class ExpandedFab extends StatelessWidget {
//   const ExpandedFab({
//     super.key,
//     required this.listTasksRef,
//     required this.reduceIndex,
//   });

//   final listTasksRef;
//   final VoidCallback reduceIndex;

//   @override
//   Widget build(BuildContext context) {
//     return SpeedDial(
//       icon: Icons.more_vert,
//       activeIcon: Icons.close,
//       backgroundColor: Theme.of(context).colorScheme.secondary,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       overlayColor: Colors.black,
//       overlayOpacity: 0.8,
//       children: [
//         SpeedDialChild(
//             labelStyle: TextStyle(
//               color: AppColors.primaryColor,
//               fontSize: 14,
//             ),
//             label: "Rename list",
//             child: Icon(Icons.edit),
//             onTap: () {
//               AppBottomSheetInkwell(
//                   sheetTriggerWidget: SizedBox(
//                     height: 20,
//                     width: 20,
//                   ),
//                   sheetTitle: "Rename your list",
//                   sheetWidgetList: [],
//                   sheetSubmitAction: () {
//                     ListsProvider.updateList(listTasksRef, "bills");
//                   });
//             }),
//         SpeedDialChild(
//             labelStyle: TextStyle(
//               color: AppColors.primaryColor,
//               fontSize: 14,
//             ),
//             label: "Delete list",
//             child: Icon(Icons.delete),
//             onTap: () {
//               ListsProvider.deleteList(listTasksRef);
//               reduceIndex();
//             }),
//       ],
//     );
//   }
// }
