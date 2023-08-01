import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      scrolledUnderElevation: 0,
      centerTitle: true,
      toolbarHeight: kToolbarHeight + 20,
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.displayLarge,
          children: <TextSpan>[
            TextSpan(text: 'jo'),
            TextSpan(
              text: 't',
              style: TextStyle(
                letterSpacing: -4,
              ),
            ),
            TextSpan(
                text: 'task.',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
      ),
    );
  }
}
