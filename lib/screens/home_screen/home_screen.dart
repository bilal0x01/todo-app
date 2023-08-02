import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen/widgets/lists_dashboard.dart';
import 'package:todo_app/screens/home_screen/widgets/app_bar.dart';
import 'package:todo_app/services/database/lists_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: StreamBuilder(
          stream: ListsProvider.getData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.data == null || snapshot.data!.isEmpty) {
              ListsProvider.createList("My Tasks");
              return const CircularProgressIndicator();
            }
            return ListsDashboard(listsData: snapshot.data!);
          },
        ),
      ),
    );
  }
}
