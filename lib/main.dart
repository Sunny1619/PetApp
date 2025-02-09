import 'package:flutter/material.dart';
import 'package:petapp3/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

  runApp(MyApp(startScreen: onboardingComplete ? HomeScreen() : WelcomeScreen()));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  MyApp({required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startScreen,
    );
  }
}
