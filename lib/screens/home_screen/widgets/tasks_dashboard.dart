import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen/widgets/task_item.dart';
import 'package:todo_app/theme/spaces.dart';

import '../../../services/database/tasks_provider.dart';
import '../../../theme/app_colors.dart';

class TasksDashboard extends StatelessWidget {
  const TasksDashboard({super.key, required this.listTasksReference});
  final listTasksReference;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TasksProvider.getData(listTasksReference),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.library_books,
                    color: AppColors.secondaryColor,
                    size: 56,
                  ),
                  Text(
                    "No tasks yet!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Add your to-dos and keep track of them here",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                TaskItem(
                  taskData: (snapshot.data![index]),
                  listTasksReference: listTasksReference,
                ),
                smallVertSpace,
              ],
            );
          },
          itemCount: snapshot.data!.length,
        );
      },
    );
  }
}
