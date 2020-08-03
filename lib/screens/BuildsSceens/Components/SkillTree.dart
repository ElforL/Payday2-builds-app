import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pd2_builds/screens/BuildsSceens/Components/SkillsCard.dart';
import 'package:pd2_builds/skills/Build.dart';

// ignore: must_be_immutable
class SkillTree extends StatefulWidget {
  
  SkillsCardState parent;
  int treeNum;
  Build curntBuild;
  bool editable;

  SkillTree(this.treeNum, this.curntBuild, this.editable, this.parent);

  @override
  _SkillTreeState createState() => _SkillTreeState(treeNum, curntBuild, editable);
}

class _SkillTreeState extends State<SkillTree> {

  int treeNum;
  Build curntBuild;
  bool editable;

  _SkillTreeState(this.treeNum, this.curntBuild, this.editable);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ///////////////////////////// Tree 1 /////////////////////////////
        Expanded(
          child: Table(
            children: [
              TableRow(
                children: [
                  Container(),
                  SkillBtn([treeNum,1,6],curntBuild,editable, widget.parent),
                  Container()
                ]
              ),
              TableRow(
                children: [
                  SkillBtn([treeNum,1,4],curntBuild,editable, widget.parent),
                  Container(),
                  SkillBtn([treeNum,1,5],curntBuild,editable, widget.parent)
                ]
              ),
              TableRow(
                children: [
                  SkillBtn([treeNum,1,2],curntBuild,editable, widget.parent),
                  Container(),
                  SkillBtn([treeNum,1,3],curntBuild,editable, widget.parent)
                ]
              ),
              TableRow(
                children: [
                  Container(),
                  SkillBtn([treeNum,1,1],curntBuild,editable, widget.parent),
                  Container()
                ]
              ),
            ],
          )
        ),
        ///////////////////////////// Tree 2 /////////////////////////////
        Expanded(
          child: Table(
            children: [
              TableRow(
                children: [
                  Container(),
                  SkillBtn([treeNum,2,6],curntBuild,editable, widget.parent),
                  Container()
                ]
              ),
              TableRow(
                children: [
                  SkillBtn([treeNum,2,4],curntBuild,editable, widget.parent),
                  Container(),
                  SkillBtn([treeNum,2,5],curntBuild,editable, widget.parent)
                ]
              ),
              TableRow(
                children: [
                  SkillBtn([treeNum,2,2],curntBuild,editable, widget.parent),
                  Container(),
                  SkillBtn([treeNum,2,3],curntBuild,editable, widget.parent)
                ]
              ),
              TableRow(
                children: [
                  Container(),
                  SkillBtn([treeNum,2,1],curntBuild,editable, widget.parent),
                  Container(),
                ]
              ),
            ],
          )
        ),
        ///////////////////////////// Tree 3 /////////////////////////////
        Expanded(
          child: Table(
            children: [
              TableRow(
                children: [
                  Container(),
                  SkillBtn([treeNum,3,6],curntBuild,editable, widget.parent),
                  Container()
                ]
              ),
              TableRow(
                children: [
                  SkillBtn([treeNum,3,4],curntBuild,editable, widget.parent),
                  Container(),
                  SkillBtn([treeNum,3,5],curntBuild,editable, widget.parent)
                ]
              ),
              TableRow(
                children: [
                  SkillBtn([treeNum,3,2],curntBuild,editable, widget.parent),
                  Container(),
                  SkillBtn([treeNum,3,3],curntBuild,editable, widget.parent)
                ]
              ),
              TableRow(
                children: [
                  Container(),
                  SkillBtn([treeNum,3,1],curntBuild,editable, widget.parent),
                  Container()
                ]
              ),
            ],
          )
        )

      ],
    );
  }
}

// ignore: must_be_immutable
class SkillBtn extends StatefulWidget {
  SkillsCardState skillcardstate;
  bool editable;
  List<int> location;
  Build curntBuild;
  
  SkillBtn(List<int> location, Build curntBuild, this.editable, this.skillcardstate){
    this.location = location;
    this.curntBuild = curntBuild;
  }

  @override
  _SkillBtnState createState() => _SkillBtnState(location, curntBuild, editable);
}

class _SkillBtnState extends State<SkillBtn> {
  bool editable;
  Build curntBuild;
  List<int> location;
  Image image;
  
  
  _SkillBtnState(List<int> location, Build curntBuild, this.editable){
    this.curntBuild = curntBuild;
    this.location = location;
    
  }

  @override
  Widget build(BuildContext context) {

    if(curntBuild.getSubTrees()[((location[0]-1)*3+(location[1]-1))].getOptions()[location[2]-1] == 0){
      image = Image.asset(
              "assets/images/skill trees/"+location[0].toString()+"/${location[1]}${location[2]}.png",
              color: Colors.grey[800],);
    }else if(curntBuild.getSubTrees()[((location[0]-1)*3+(location[1]-1))].getOptions()[location[2]-1] == 1 ){
      image = Image.asset(
              "assets/images/skill trees/"+location[0].toString()+"/${location[1]}${location[2]}.png");
    }else if(curntBuild.getSubTrees()[((location[0]-1)*3+(location[1]-1))].getOptions()[location[2]-1] > 1){
      image = Image.asset(
              "assets/images/skill trees/"+location[0].toString()+"/${location[1]}${location[2]}.png",
              color: Colors.blue[800]);
    }

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: image
          ),
        ),
        onTap: editable?(){
          setState(() {
            curntBuild.upgradeOption(((location[0]-1)*3+(location[1]-1))+1, location[2]-1);
            if(curntBuild.getSubTrees()[((location[0]-1)*3+(location[1]-1))].getOptions()[location[2]-1] == 0){
              image = Image.asset(
                      "assets/images/skill trees/"+location[0].toString()+"/${location[1]}${location[2]}.png",
                      color: Colors.grey[800],);
            }else if(curntBuild.getSubTrees()[((location[0]-1)*3+(location[1]-1))].getOptions()[location[2]-1] == 1 ){
              image = Image.asset(
                      "assets/images/skill trees/"+location[0].toString()+"/${location[1]}${location[2]}.png");
            }else if(curntBuild.getSubTrees()[((location[0]-1)*3+(location[1]-1))].getOptions()[location[2]-1] > 1){
              image = Image.asset(
                      "assets/images/skill trees/"+location[0].toString()+"/${location[1]}${location[2]}.png",
                      color: Colors.blue[800]);
            }  
          });
          widget.skillcardstate.setState(() { });
        }:null, //if the card is not editable it'll return null
        onLongPress: editable? (){
          setState(() {
            curntBuild.degradeOption(((location[0]-1)*3+(location[1]-1))+1, location[2]-1);
            if(curntBuild.getSubTrees()[((location[0]-1)*3+(location[1]-1))].getOptions()[location[2]-1] == 0){
              image = Image.asset(
                      "assets/images/skill trees/"+location[0].toString()+"/${location[1]}${location[2]}.png",
                      color: Colors.grey[800],);
            }else if(curntBuild.getSubTrees()[((location[0]-1)*3+(location[1]-1))].getOptions()[location[2]-1] == 1 ){
              image = Image.asset(
                      "assets/images/skill trees/"+location[0].toString()+"/${location[1]}${location[2]}.png");
            }else if(curntBuild.getSubTrees()[((location[0]-1)*3+(location[1]-1))].getOptions()[location[2]-1] > 1){
              image = Image.asset(
                      "assets/images/skill trees/"+location[0].toString()+"/${location[1]}${location[2]}.png",
                      color: Colors.blue[800]);
            }
          });
          widget.skillcardstate.setState(() { });
        }: null, //if the card is not editable it'll return null
      ),

    );
  }
}