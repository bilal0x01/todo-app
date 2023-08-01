import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen/widgets/lists_dashboard.dart';
import 'package:todo_app/screens/home_screen/widgets/app_bar.dart';
import 'package:todo_app/services/database/lists_provider.dart';

class HomeScreen extends StatelessWidget {
  late final List<Map<String, dynamic>> listsDataMap1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomeAppBar(),
        body: StreamBuilder(
          stream: ListsProvider.getData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.data == null || snapshot.data!.isEmpty) {
              ListsProvider.createList("My Tasks");
              return CircularProgressIndicator();
            }
            return ListsDashboard(listsData: snapshot.data!);
          },
        ),
      ),
    );
  }
}
