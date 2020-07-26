// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:pd2_builds/skills/Build.dart';
import 'screens/HomePage.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  static List<Build> myBuilds = new List<Build>();

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        accentColor: Colors.blue[800],
        fontFamily: 'Roboto',
      ),
      home: HomePage(myBuilds)
    );
  }
}

