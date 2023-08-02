import 'package:flutter/material.dart';

class ListItemAnimation extends StatelessWidget {
  const ListItemAnimation({
    super.key,
    required this.selectedList,
    required this.previousSelectedList,
    required AnimationController slideController,
    required this.index,
    required this.listsData,
  }) : _slideController = slideController;

  final int selectedList;
  final int previousSelectedList;
  final AnimationController _slideController;
  final int index;
  final List<Map<String, dynamic>> listsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(listsData[index]['docData']['listName'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: index == selectedList
                      ? Theme.of(context).colorScheme.secondary
                      : null,
                )),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset((previousSelectedList - index.toDouble()), 0),
                  end: const Offset(0, 0),
                ).animate(_slideController),
                child: index == selectedList
                    ? Container(
                        height: 2,
                        margin: const EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    : const SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
