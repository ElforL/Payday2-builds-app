import 'package:flutter/material.dart';
import 'package:pd2_builds/constants.dart';
import 'package:pd2_builds/screens/BuildsSceens/BuildEdit.dart';
import 'package:pd2_builds/screens/BuildsSceens/BuildPreview.dart';
import 'package:pd2_builds/screens/BuildsSceens/Components/Icons.dart';
import 'package:pd2_builds/skills/Build.dart';
import 'package:pd2_builds/skills/BuildsServices.dart';

// ignore: must_be_immutable
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
  void initState() {
    super.initState();
    loadBuilds();
  }

  // Loads the builds from the save JSON file
  loadBuilds() async{
    buildList = await BuildsServices.loadBuilds();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    // the home page list viewer shows builds in the filterdbuilds List
    // so we get all the build that its title contains the filter from buildsList to filterdBuilds
    filteredBuilds = buildList.where((u) => (u.getTitle().toLowerCase().contains(filter.toLowerCase()))).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Builds',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          children: [

            ////// Search Bar //////
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

            ////// Builds cards //////
            /// if there's no builds in the list build an expanded widget that contains a "no builds" message
            /// if there is, build the ListView
            buildList.length > 0 ?
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(15),
                // multiply by two to account for the divider(SizedBox)
                itemCount: filteredBuilds.length*2,
                itemBuilder: (context, i) {
                  if(i.isEven) return SizedBox(height: 15);

                  int index = i ~/2 ;
                  return _buildRow(index);
                },
              ),
            ):

            /// no builds image
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/2.png",
                    color: Colors.grey[800],
                  ),
                  Text("No Builds",
                    style: TextStyle(
                      color: Colors.grey[800]
                    ), 
                  )
                ]
              ),
            ),
        ]),
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
    
    return Material(
      color: kSurfaceColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            children: <Widget>[

              // Perk deck icon
              Container(
                // size of the image
                height: 35,
                child: ClipRect(
                  child: FittedBox(
                    child: Align(
                      alignment: Alignment(
                        /// gettin the alignment value from the row/col index:
                        /// the alignment value is from -1 to 1
                        /// so i calculated it from 0 to 2 and then subtracted 1
                        /// < row or column inex statring from 0> * (2 / (<total number of rows or columns> - 1)) - 1
                        /// for this image there's 5 columns so the value for the 3rd column = 
                        /// 2 * (2 / (5 - 1)) - 1

                        // (column*(2/4))-1 converts the column index to alignment value
                        (PdIcons.perksLocations[PdIcons.perksNames.indexOf(filteredBuilds[index].getPerk())][0]*(2/4))-1,
                        // (row*(2/21))-1 converts the row index to alignment value
                        (PdIcons.perksLocations[PdIcons.perksNames.indexOf(filteredBuilds[index].getPerk())][1]*(2/21))-1
                      ),
                      
                      // heightFactor = <icon height> / <full image height>
                      // widthFactor = <icon width> / <full image width>
                      heightFactor: 0.045,
                      widthFactor: 0.2,
                      child: Image.asset(
                        "assets/images/perkdecks/icons.png",
                        color: kTextOnSurface,
                      ),
                    ),
                  ),
                ),
              ),

              // Divider
              SizedBox(width: 20),

              // Build Title
              Text(
                filteredBuilds[index].getTitle(),
                style: TextStyle(
                  fontSize: 20,
                  color: kTextOnSurface
                ),
              ),

            ],
          ),
        ),
        onTap: () async{
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuildPreviewPage(buildList, filteredBuilds[index])),
          );
          setState(() {
          });
        },
        onLongPress: (){},
      ),
    );
  }
  
}