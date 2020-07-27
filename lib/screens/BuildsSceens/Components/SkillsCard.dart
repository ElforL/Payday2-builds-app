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
  _SkillsCardState createState() => _SkillsCardState();
}

class _SkillsCardState extends State<SkillsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 5, 
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: <Widget>[
              TabBar(tabs: [
                Tab(text: "Mastermind", icon: Icon(Icons.healing)),
                Tab(text: "Enforcer",   icon: Icon(Icons.security)),
                Tab(text: "Tech",       icon: Icon(Icons.tap_and_play)),
                Tab(text: "Ghost",      icon: Icon(Icons.remove_red_eye) ),
                Tab(text: "Fugitive",   icon: Icon(Icons.not_interested)),
                ]
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SkillTree(1,widget.curntBuild,widget.editable),
                    SkillTree(2,widget.curntBuild,widget.editable),
                    SkillTree(3,widget.curntBuild,widget.editable),
                    SkillTree(4,widget.curntBuild,widget.editable),
                    SkillTree(5,widget.curntBuild,widget.editable),
                ],
                )
              )
            ],
          )
        )
      ),
    );
  }
}