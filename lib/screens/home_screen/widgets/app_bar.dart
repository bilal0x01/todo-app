import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      centerTitle: true,
      toolbarHeight: kToolbarHeight + 20,
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.displayLarge,
          children: <TextSpan>[
            const TextSpan(text: 'jo'),
            const TextSpan(
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
