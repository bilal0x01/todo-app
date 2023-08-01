import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.editCompleteFunction,
      required this.fieldController,
      required this.fieldHintText,
      required this.nextIconKeyboard});
  final void Function()? editCompleteFunction;
  final TextEditingController fieldController;
  final String fieldHintText;
  final bool nextIconKeyboard;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: nextIconKeyboard ? TextInputAction.next : null,
      onEditingComplete: editCompleteFunction,
      autofocus: true,
      cursorColor: Theme.of(context).colorScheme.secondary,
      controller: fieldController,
      decoration: InputDecoration(
        hintText: fieldHintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        border: InputBorder.none,
      ),
    );
  }
}
