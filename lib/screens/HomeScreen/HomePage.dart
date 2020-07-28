import 'package:flutter/material.dart';
import 'package:pd2_builds/screens/BuildsSceens/BuildEdit.dart';
import 'package:pd2_builds/screens/BuildsSceens/BuildPreview.dart';
import 'package:pd2_builds/screens/BuildsSceens/Components/Icons.dart';
import 'package:pd2_builds/skills/Build.dart';

class HomePage extends StatefulWidget{
  
  List<Build> buildList;

  HomePage(List<Build> buildList){
    this.buildList = buildList;
  }

  @override
  _HomePageState createState() => _HomePageState(buildList);
}

class _HomePageState extends State<HomePage> {

  List<Build> buildList;
  List<Build> filteredBuilds = new List();
  String filter;
  
  _HomePageState(List<Build> buildList){
    this.buildList = buildList;
    filteredBuilds = buildList;
    filter = "";
  }

  @override
  Widget build(BuildContext context) {
    filteredBuilds = buildList.where((u) => (u.getTitle().toLowerCase().contains(filter.toLowerCase()))).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Builds',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [

          //Search Bar
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
                  filter = string;
              });
              },
            ),
          ),

          //Cards
          buildList.length > 0 ?
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: filteredBuilds.length*2,
              itemBuilder: (context, i) {
                if(i.isEven) return SizedBox(height: 15);

                int index = i ~/2 ;
                return _buildRow(index);
              },
            ),
          ):
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/2.png",
                  color: Colors.grey[800],
                ),
                Text("No Builds",
                  style: TextStyle(
                    color: Colors.grey
                  ), 
                )
              ]
            ),
          ),
        ]
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        label: Text("New Build"),
        icon: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuildEditPage(new Build("New Build"),buildList)),
          );
          setState(() {
            
          });
        },
      ),
    );
  }

  Widget _buildRow(int index){
    return SafeArea(
      bottom: false,
      child: Material(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(right:15, left: 15, top:20, bottom: 20),
              child: Row(
                children: <Widget>[

                  Container(
                    // color: Colors.red,
                    height: 35,
                    child: ClipRect(
                      child: FittedBox(
                        child: Align(
                          alignment: Alignment(
                            //x
                            (PdIcons.perksLocations[PdIcons.perksNames.indexOf(filteredBuilds[index].getPerk())][0]*(2/7))-1,
                            //y
                            (PdIcons.perksLocations[PdIcons.perksNames.indexOf(filteredBuilds[index].getPerk())][1]*(2/7))-1
                          ),
                          heightFactor: .125,
                          widthFactor: .125,
                          child: Image.asset(
                            "assets/images/perkdecks/icons_atlas.png"
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  Text(
                    filteredBuilds[index].getTitle(),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ),
          ),
          onTap: () async{
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BuildPreviewPage(buildList, buildList[index])),
            );
            setState(() {

            });
          },
          onLongPress: (){},
        ),
      ),
    );
  }
  
}