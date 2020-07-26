import 'package:flutter/material.dart';
import 'package:pd2_builds/main.dart';
import 'package:pd2_builds/screens/SkillTree.dart';
import 'package:pd2_builds/skills/Build.dart';

class BuildEditPage extends StatefulWidget {
  Build curntBuild;
  Build tmpBuild;
  List<Build> buildsList;

  BuildEditPage(this.curntBuild, this.buildsList);

  @override
  _BuildEditPageState createState() => _BuildEditPageState(curntBuild, buildsList);
}

class _BuildEditPageState extends State<BuildEditPage> {

  Build curntBuild;
  List<Build> buildsList;
  TextField titleTF;

  _BuildEditPageState(Build curntBuild, List<Build> buildList){
    this.buildsList = buildList;
    this.curntBuild = curntBuild;
  }

  @override
  void initState() {
    super.initState();
    titleTF = TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        hintText: 'Build Name',
      ),
      controller: TextEditingController(text: widget.curntBuild.getTitle()),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //////////////////////////// AppBar ////////////////////////////
      appBar: AppBar(
        title: titleTF
      ),

      //////////////////////////// Body ////////////////////////////
      body: Column(
        children: <Widget>[
          //////////////////////////// Skills ////////////////////////////
          Expanded(
            child: DefaultTabController(length: 5, child: 
                  Scaffold(
                    body: Column(
                      children: <Widget>[
                        TabBar(tabs: [
                        Tab(text: "Mastermind", icon: Icon(Icons.healing)),
                        Tab(text: "Enforcer",   icon: Icon(Icons.security)),
                        Tab(text: "Tech",       icon: Icon(Icons.tap_and_play)),
                        Tab(text: "Ghost",      icon: Icon(Icons.remove_red_eye) ),
                        Tab(text: "Fugitive",   icon: Icon(Icons.not_interested)),
                        ]),
                        Expanded(
                          child: TabBarView(
                            children: [
                              SkillTree(1,curntBuild),
                              SkillTree(2,curntBuild),
                              SkillTree(3,curntBuild),
                              SkillTree(4,curntBuild),
                              SkillTree(5,curntBuild),
                          ],
                          )
                        )
                      ],
                    )
                  )
                )
          ),
          //////////////////////////// Save Buttons ////////////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                //Discard
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blue)
                  ),
                  textColor: Colors.blue,
                  onPressed: (){},
                  child: Text("Discard")
                ),
                SizedBox(width: 100,),
                //Save
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Colors.blue,
                  textColor: Colors.black,
                  child: Text("Save"),
                  onPressed: () {
                    curntBuild.setTitle(titleTF.controller.text);
                    if(!buildsList.contains(curntBuild)){
                      buildsList.add(curntBuild);
                    }
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ],
      ), //end of body
    );
  }
}

