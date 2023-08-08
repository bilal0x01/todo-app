import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/registration_screen/registration_screen.dart';
import 'theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
          displayMedium: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
          bodyLarge: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 16,
            color: AppColors.textColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Raleway",
            fontSize: 16,
            color: AppColors.textColor,
          ),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: AppColors.textColor,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: const MaterialStatePropertyAll(28),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.all(15),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            foregroundColor: const MaterialStatePropertyAll(
              AppColors.textColor,
            ),
            backgroundColor:
                const MaterialStatePropertyAll(AppColors.secondaryColor),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            overlayColor:
                const MaterialStatePropertyAll(AppColors.secondaryColor),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.textColor),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.textColor),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundColor,
          actionsIconTheme: IconThemeData(color: AppColors.textColor),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.backgroundColor,
          dragHandleColor: AppColors.textColor,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          background: AppColors.backgroundColor,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.secondaryColor,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: AppColors.secondaryColor,
          contentTextStyle: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          errorStyle: TextStyle(height: 0.2),
        ),
        useMaterial3: true,
      ),
      home: SafeArea(
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (snapshot.data!.emailVerified) {
                return HomeScreen(userId: snapshot.data!.uid);
              } else {
                FirebaseAuth.instance.signOut();
                Future.delayed(const Duration(milliseconds: 500), () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please verify your email to proceed.'),
                    ),
                  );
                });
                return const RegistrationScreen();
              }
            } else {
              return const RegistrationScreen();
            }
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
