// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/services/database/tasks_provider.dart';
import 'package:todo_app/theme/app_colors.dart';

class TasksDashboard extends StatefulWidget {
  const TasksDashboard({super.key, required this.listTasksReference});
  final listTasksReference;

  @override
  State<TasksDashboard> createState() => _TasksDashboardState();
}

class _TasksDashboardState extends State<TasksDashboard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TasksProvider.getData(widget.listTasksReference),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width / 2,
              child: Column(
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.check_box_outline_blank),
                      color: AppColors.textColor,
                      onPressed: () {},
                    ),
                    title: Text(snapshot.data![index]['docData']['taskName']),
                    subtitle:
                        Text(snapshot.data![index]['docData']['taskDetails']),
                  ),
                ),
              ],
            );
          },
          itemCount: snapshot.data!.length,
        );
      },
    );
  }
}
