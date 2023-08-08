import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.displayLarge,
        children: [
          const TextSpan(text: 'jo'),
          const TextSpan(
            text: 't',
            style: TextStyle(
              letterSpacing: -4,
            ),
          ),
          TextSpan(
              text: 'task.',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        ],
      ),
    );
  }
}
