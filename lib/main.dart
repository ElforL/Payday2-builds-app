import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pd2_builds/constants.dart';
import 'package:pd2_builds/skills/Build.dart';
import 'screens/HomeScreen/HomePage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  static List<Build> buildsList = new List<Build>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp, 
        DeviceOrientation.portraitDown
      ]
    );
    return MaterialApp(
      title: 'Payday 2 Builds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBackgroundColor,
        appBarTheme: AppBarTheme(
          color: kBackgroundColor,
          elevation: 0
        ),
        textSelectionHandleColor: Colors.blue[100],
        primaryColor: kPrimaryColor,
        accentColor: kSecondaryColor,
        fontFamily: 'Roboto',
      ),
      home: HomePage(buildsList)
      
    );
  }
}

