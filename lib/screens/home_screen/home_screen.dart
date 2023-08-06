import 'package:flutter/material.dart';

import 'widgets/lists_dashboard.dart';
import '../../services/auth/auth_provider.dart';
import '../../services/database/lists_provider.dart';
import '../../widgets/design/app_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          toolbarHeight: kToolbarHeight + 20,
          title: const AppLogo(),
          actions: const [
            TextButton(
              onPressed: AuthProvider.logout,
              child: Row(
                children: [
                  Icon(Icons.logout),
                ],
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: ListsProvider.getData(userId: userId),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == null || snapshot.data!.isEmpty) {
              ListsProvider.createList("My Tasks", userId);
              return const Center(child: CircularProgressIndicator());
            }
            return ListsDashboard(
              listsData: snapshot.data!,
              userId: userId,
            );
          },
        ),
      ),
    );
  }
}
