import 'package:flutter/material.dart';
import 'package:pd2_builds/skills/Build.dart';

import 'SkillTree.dart';


class SkillsCard extends StatefulWidget {

  final Build curntBuild;
  final bool editable;

  SkillsCard({
    Key key,
    @required this.curntBuild,
    this.editable = true
  }) : super(key: key);

  SkillsCard.preview(Build curntBuild): this.curntBuild = curntBuild, editable = false;

  @override
  SkillsCardState createState() => SkillsCardState();
}

class SkillsCardState extends State<SkillsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20)
      ),
      child: DefaultTabController(
        length: 5, 
        child: Column(
          children: <Widget>[
            ///////////////////////////// TabBar /////////////////////////////
            TabBar(tabs: [
              Tab(text: "Mastermind", icon: Icon(Icons.healing)),
              Tab(text: "Enforcer",   icon: Icon(Icons.security)),
              Tab(text: "Tech",       icon: Icon(Icons.tap_and_play)),
              Tab(text: "Ghost",      icon: Icon(Icons.remove_red_eye) ),
              Tab(text: "Fugitive",   icon: Icon(Icons.not_interested)),
              ]
            ),
            ///////////////////////////// Trees /////////////////////////////
            Expanded(
              child: TabBarView(
                children: [
                  SkillTree(1, widget.curntBuild, widget.editable, this),
                  SkillTree(2, widget.curntBuild, widget.editable, this),
                  SkillTree(3, widget.curntBuild, widget.editable, this),
                  SkillTree(4, widget.curntBuild, widget.editable, this),
                  SkillTree(5, widget.curntBuild, widget.editable, this),
              ],
              )
            ),
            ///////////////////////////// Points /////////////////////////////
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Spent Points: ${widget.curntBuild.getSpentPnts()}",
                    style: TextStyle(
                      color: !widget.editable? Colors.grey[800]: Colors.grey[300]
                    ),
                  ),
                  Text("Available Points: ${widget.curntBuild.getAvailablePnts()}",
                    style: TextStyle(
                      color: !widget.editable? Colors.grey[800]: Colors.grey[300]
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}