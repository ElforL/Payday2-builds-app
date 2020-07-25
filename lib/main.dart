// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'skills/Build.dart';



void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
        accentColor: Colors.blue[800]
      ),
      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Builds',style: TextStyle(fontSize: 25),),
      ),
      body: ListSearch(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("New Build"),
        icon: Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
  
}

class ListSearch extends StatefulWidget {
  @override
  _ListSearchState createState() => _ListSearchState();
}

class _ListSearchState extends State<ListSearch> {

  List<String> tiles = [];
  List<String> filteredTiles = new List();
  
  @override
  void initState() {
    super.initState();
    tiles = ["Ahmad","Sarah","Bob","Jem","Sarah","Bruh"];
    filteredTiles = tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left:20, right:20),
          child: TextField(
            decoration: InputDecoration(
              fillColor: Colors.red,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Search',
              focusColor: Colors.blue[900]
            ),
            onChanged: (string) {
                setState(() {
                  filteredTiles = tiles.where((u) => (u.toLowerCase().contains(string.toLowerCase()))).toList();
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: filteredTiles.length*2,
            itemBuilder: (context, i) {
              if(i.isEven) return SizedBox(height: 10);

              int index = i ~/2 ;
              return _buildRow(filteredTiles[index]);
            },
          ),
        )
      ]
    );
  }

  Widget _buildRow(String title){
    return Material(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(title),
          ),
        ),
        onTap: (){Scaffold.of(context).showSnackBar(SnackBar(content: Text(title), duration: Duration(milliseconds: 50),));},
        onLongPress: (){},
      ),
    );
    
  }
}