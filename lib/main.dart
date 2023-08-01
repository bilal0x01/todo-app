import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen/home_screen.dart';
import 'package:todo_app/theme/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        textTheme: TextTheme(
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
        listTileTheme: ListTileThemeData(
          textColor: AppColors.textColor,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconSize: MaterialStatePropertyAll(28),
            padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            foregroundColor: MaterialStatePropertyAll(AppColors.textColor),
            backgroundColor: MaterialStatePropertyAll(AppColors.secondaryColor),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            overlayColor: MaterialStatePropertyAll(AppColors.secondaryColor),
            foregroundColor: MaterialStatePropertyAll(AppColors.textColor),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          background: AppColors.backgroundColor,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.backgroundColor,
          dragHandleColor: AppColors.textColor,
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
