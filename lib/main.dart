// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'skills/Build.dart';



void main(){
  runApp(MyApp());
}

class BuildsHelper{
  static List<Build> builds;
  static void loadBuilds(){

  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    BuildsHelper.loadBuilds();
    List<Widget> tiles = [
      ListTile(title: Text('A')),
      ListTile(title: Text('B')),
      ListTile(title: Text('C')),
      ListTile(title: Text('D')),
      ListTile(title: Text('E')),
    ];
    if(BuildsHelper.builds != null)
      for (var i = 0; i < BuildsHelper.builds.length; i++) {
      
      }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Builds'),
      ),
      body: ListView(
          children: ListTile.divideTiles(context: context, tiles: tiles).toList()
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            DrawerHeader(
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),

            ListTile(
              title: Text("Settings"),
              trailing: Icon(Icons.settings),
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context){
                      return BuildTree(title: 'settings');
                    }
                  ,)
                );
              },
            ),

            Divider(),

          ],
        )
      )
    );
  }
  
}

class BuildTree extends StatelessWidget{
  final String title;

  const BuildTree({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          buildGrid(1)
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        
      )
      
    );
  }

  //skip 0 2 4 7 9 11
  Widget buildGrid(int treeNum){
    
    List<Column> subtrees = new List<Column>(3);
    
    for (var i = 0; i < 3; i++) {
      List<Widget> containers = new List<Widget>(12);
      int count = 0;
      for (var j = 0; j < containers.length; j++) {
        if(j == 0 || j == 2 || j == 4 || j == 7 || j == 9 || j == 11 )
          containers[j] = Center();
        else{
          count++;
          containers[11-j] = Container(
            child: Image.asset('assets/images/skill trees/$treeNum/${i+1}$count.png'),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.blue[800]
                ]
              )
            ),
          ); //add
        }
      }
      subtrees[i] = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              children: containers,
            ),
          ],
        );
      
    }

    GridView tree = GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      childAspectRatio: .6,
      children: subtrees,
    );


    return tree;
  }

  
}
