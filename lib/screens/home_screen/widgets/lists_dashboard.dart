import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen/widgets/app_text_field.dart';
import 'package:todo_app/services/database/lists_provider.dart';
import 'package:todo_app/theme/app_colors.dart';
import 'package:todo_app/screens/home_screen/widgets/ListItemAnimation.dart';
import 'package:todo_app/screens/home_screen/widgets/list_content.dart';
import 'package:todo_app/theme/spaces.dart';
import 'package:todo_app/utils/show_bottomsheet.dart';

class ListsDashboard extends StatefulWidget {
  const ListsDashboard({super.key, required this.listsData});

  final List<Map<String, dynamic>> listsData;

  @override
  State<ListsDashboard> createState() => _ListsDashboardState();
}

class _ListsDashboardState extends State<ListsDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  int selectedList = 0;
  int previousSelectedList = 0;
  final listTitleController = TextEditingController();

  void reduceIndex() {
    selectedList > 0 ? selectedList-- : selectedList;
  }

  void addList() {
    if (listTitleController.text.isEmpty) {
      return null;
    }
    ListsProvider.createList(listTitleController.text);
  }

  void submitData() {
    Navigator.pop(context);
    addList();
    listTitleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          height: 40,
          alignment: Alignment.center,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return index == widget.listsData.length
                  ? InkWell(
                      onTap: () {
                        showInputBottomSheet(
                          context: context,
                          sheetTitle: "Create new list",
                          sheetWidgetList: [
                            AppTextField(
                              editCompleteFunction: submitData,
                              fieldController: listTitleController,
                              fieldHintText: "Enter list title",
                              nextIconKeyboard: false,
                            ),
                            
                          ],
                          sheetSubmitAction: submitData,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColors.textColor,
                              size: 16,
                            ),
                            Text(
                              "New List",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          previousSelectedList = selectedList.toInt();
                          selectedList = index;
                        });
                        _slideController.reset();
                        _slideController.forward();
                      },
                      child: ListItemAnimation(
                        index: index,
                        listsData: widget.listsData,
                        selectedList: selectedList,
                        previousSelectedList: previousSelectedList,
                        slideController: _slideController,
                      ),
                    );
            },
            itemCount: widget.listsData.length + 1,
          ),
        ),
        mediumVertSpace,
        ListContent(
          listsData: widget.listsData,
          selectedList: selectedList,
          reduceIndex: reduceIndex,
        )
      ],
    );
  }
}
