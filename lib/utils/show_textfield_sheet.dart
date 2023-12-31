import 'package:flutter/material.dart';

import '../theme/spaces.dart';

Future<dynamic> showTextfieldSheet({
  required BuildContext context,
  required String sheetTitle,
  required List<Widget> sheetWidgetList,
  required VoidCallback sheetSubmitAction,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 20,
          left: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sheetTitle,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                OutlinedButton(
                  onPressed: sheetSubmitAction,
                  child: const Text(
                    "Done",
                  ),
                ),
              ],
            ),
            mediumVertSpace,
            ...sheetWidgetList.map((e) {
              return e;
            }).toList()
          ],
        ),
      );
    },
  );
}
