import 'package:flutter/material.dart';
import 'package:pd2_builds/screens/BuildsSceens/Components/SkillTree.dart';
import 'package:pd2_builds/skills/Build.dart';

import 'Components/PerkDeckCard.dart';
import 'Components/SkillsCard.dart';

class BuildEditPage extends StatefulWidget {
  Build curntBuild;
  List<Build> buildsList;

  BuildEditPage(this.curntBuild, this.buildsList);

  @override
  _BuildEditPageState createState() => _BuildEditPageState(curntBuild, buildsList);
}

class _BuildEditPageState extends State<BuildEditPage> {

  Build curntBuild;
  List<Build> buildsList;
  TextField titleTF;
  String perkVal;

  _BuildEditPageState(Build curntBuild, List<Build> buildList){
    this.buildsList = buildList;
    this.curntBuild = curntBuild;
  }

  @override
  void initState() {
    super.initState();
    perkVal = curntBuild.getPerk();
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
      resizeToAvoidBottomInset: false,
      //////////////////////////// AppBar ////////////////////////////
      appBar: AppBar(
        title: titleTF,
        actions: <Widget>[

          IconButton(
            padding: EdgeInsets.all(20),
            icon: Icon(Icons.text_fields),
            onPressed: (){
              showImportDialog(context);
            }
          )

        ],
      ),

      //////////////////////////// Body ////////////////////////////
      body: Column(
        children: <Widget>[
          //////////////////////////// Skills ////////////////////////////
          Expanded(
            flex: 2,
            child: SkillsCard(curntBuild: curntBuild)
          ),

          //////////////////////////// Perk Deck ////////////////////////////
          Expanded(
            child: PerkDeckCard(curntBuild,true),
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
                  onPressed: (){
                    Navigator.pop(context);
                  },
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

  showImportDialog(BuildContext context) {
    EdgeInsets padding = EdgeInsets.only(left: 20, right: 20);
    TextField stringTF = TextField(
        maxLines: null,
        controller: TextEditingController(text: curntBuild.getExportString()));
    // set up the buttons
    Widget cancelButton = FlatButton(
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.blue,
          width: 2
        ),
      ),
      textColor: Colors.blue,
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    Widget importButton = FlatButton(
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      color: Colors.blue,
      textColor: Colors.grey[900],
      child: Text("Import", style: TextStyle(fontWeight: FontWeight.bold),),
      onPressed:  () {
        curntBuild.importByString(stringTF.controller.text);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Text("String of ${widget.curntBuild.getTitle()}"),
      content: stringTF,
      actions: [
        cancelButton,
        importButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

