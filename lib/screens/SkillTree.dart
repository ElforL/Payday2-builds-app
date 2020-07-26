import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pd2_builds/skills/Build.dart';

class SkillTree extends StatefulWidget {
  
  int treeNum;
  Build curntBuild;

  SkillTree(this.treeNum, this.curntBuild);

  @override
  _SkillTreeState createState() => _SkillTreeState(treeNum, curntBuild);
}

class _SkillTreeState extends State<SkillTree> {

  int treeNum;
  Build curntBuild;

  _SkillTreeState(this.treeNum, this.curntBuild);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///////////////////////////// Tree 1 /////////////////////////////
            Expanded(
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Container(),
                      SkillBtn([treeNum,1,6],curntBuild),
                      Container()
                    ]
                  ),
                  TableRow(
                    children: [
                      SkillBtn([treeNum,1,4],curntBuild),
                      Container(),
                      SkillBtn([treeNum,1,5],curntBuild)
                    ]
                  ),
                  TableRow(
                    children: [
                      SkillBtn([treeNum,1,2],curntBuild),
                      Container(),
                      SkillBtn([treeNum,1,3],curntBuild)
                    ]
                  ),
                  TableRow(
                    children: [
                      Container(),
                      SkillBtn([treeNum,1,1],curntBuild),
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
                      SkillBtn([treeNum,2,6],curntBuild),
                      Container()
                    ]
                  ),
                  TableRow(
                    children: [
                      SkillBtn([treeNum,2,4],curntBuild),
                      Container(),
                      SkillBtn([treeNum,2,5],curntBuild)
                    ]
                  ),
                  TableRow(
                    children: [
                      SkillBtn([treeNum,2,2],curntBuild),
                      Container(),
                      SkillBtn([treeNum,2,3],curntBuild)
                    ]
                  ),
                  TableRow(
                    children: [
                      Container(),
                      SkillBtn([treeNum,2,1],curntBuild),
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
                      SkillBtn([treeNum,3,6],curntBuild),
                      Container()
                    ]
                  ),
                  TableRow(
                    children: [
                      SkillBtn([treeNum,3,4],curntBuild),
                      Container(),
                      SkillBtn([treeNum,3,5],curntBuild)
                    ]
                  ),
                  TableRow(
                    children: [
                      SkillBtn([treeNum,3,2],curntBuild),
                      Container(),
                      SkillBtn([treeNum,3,3],curntBuild)
                    ]
                  ),
                  TableRow(
                    children: [
                      Container(),
                      SkillBtn([treeNum,3,1],curntBuild),
                      Container()
                    ]
                  ),
                ],
              )
            )

          ],
        )
    );
  }
}

class SkillBtn extends StatefulWidget {
  List<int> location;
  Build curntBuild;
  
  SkillBtn(List<int> location, Build curntBuild){
    this.location = location;
    this.curntBuild = curntBuild;
  }

  @override
  _SkillBtnState createState() => _SkillBtnState(location, curntBuild);
}

class _SkillBtnState extends State<SkillBtn> {
  Build curntBuild;
  List<int> location;
  Image image;
  
  _SkillBtnState(List<int> location, Build curntBuild){
    this.curntBuild = curntBuild;
    this.location = location;
    
  }

  @override
  void initState() {
    super.initState();

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

    
  }

  @override
  Widget build(BuildContext context) {

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
        onTap: (){
          setState(() {
            print(curntBuild.upgradeOption(((location[0]-1)*3+(location[1]-1))+1, location[2]-1));
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
            
        },
        onLongPress: (){
          setState(() {
            print(curntBuild.degradeOption(((location[0]-1)*3+(location[1]-1))+1, location[2]-1));
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
        },
      ),

    );
  }
}