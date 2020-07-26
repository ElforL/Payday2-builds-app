import 'package:flutter/material.dart';
import 'package:pd2_builds/screens/BuildEdit.dart';
import 'package:pd2_builds/skills/Build.dart';

class HomePage extends StatefulWidget{
  
  List<Build> myBuilds;

  HomePage(List<Build> myBuilds){
    this.myBuilds = myBuilds;
  }

  @override
  _HomePageState createState() => _HomePageState(myBuilds);
}

class _HomePageState extends State<HomePage> {

  List<Build> myBuilds;
  List<Build> filteredBuilds = new List();
  
  _HomePageState(List<Build> myBuilds){
    this.myBuilds = myBuilds;
  }

  @override
  void initState() {
    super.initState();
    filteredBuilds = myBuilds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Builds',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left:20, right:20),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                hintText: 'Search',
                focusColor: Colors.blue[900]
              ),
              onChanged: (string) {
                setState(() {
                  filteredBuilds = myBuilds.where((u) => (u.getTitle().toLowerCase().contains(string.toLowerCase()))).toList();
              });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: filteredBuilds.length*2,
              itemBuilder: (context, i) {
                if(i.isEven) return SizedBox(height: 10);

                int index = i ~/2 ;
                return _buildRow(index);
              },
            ),
          )
        ]
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        label: Text("New Build"),
        icon: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuildEditPage(new Build("New Build"),myBuilds)),
          );
        },
      ),
    );
  }

  Widget _buildRow(int index){
    return Material(
      color: Colors.grey[900],
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(filteredBuilds[index].getTitle()),
          ),
        ),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuildEditPage(myBuilds[index],myBuilds)),
          );
        },
        onLongPress: (){},
      ),
    );
  }
  
}