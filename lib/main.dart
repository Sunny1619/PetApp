import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';
import 'screens/PetDetailsScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool petDetailsEntered = prefs.getBool('pet_details_entered') ?? false;

  runApp(MyApp(startScreen: petDetailsEntered ? PetDetailsScreen() : WelcomeScreen()));
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
