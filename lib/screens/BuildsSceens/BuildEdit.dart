import 'package:flutter/material.dart';
import 'package:pd2_builds/constants.dart';
import 'package:pd2_builds/skills/Build.dart';
import 'package:pd2_builds/skills/BuildsServices.dart';

import 'Components/PerkDeckCard.dart';
import 'Components/SkillsCard.dart';

// ignore: must_be_immutable
class BuildEditPage extends StatefulWidget {
  Build curntBuild;
  List<Build> buildsList;

  BuildEditPage(this.curntBuild, this.buildsList);

  @override
  _BuildEditPageState createState() => _BuildEditPageState(curntBuild, buildsList);
}

class _BuildEditPageState extends State<BuildEditPage> {

  Build curntBuild;
  Build cloneBuild;
  List<Build> buildsList;
  TextField titleTF;

  _BuildEditPageState(Build curntBuild, List<Build> buildList){
    this.buildsList = buildList;
    this.curntBuild = curntBuild;
    // make a clone build so changes won't affect the curnt build
    // then only when the user press 'Save' copy the changes to the curnt build and go back
    cloneBuild = new Build(curntBuild.getTitle());
    this.cloneBuild.clone(curntBuild);
  }

  @override
  void initState() {
    super.initState();

    //sets the title textfield initial value
    titleTF = TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        hintText: 'Build Name',
      ),
      controller: TextEditingController(text: cloneBuild.getTitle()),
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

          // import/export string
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SkillsCard(curntBuild: cloneBuild),
            )
          ),

          //////////////////////////// Perk Deck ////////////////////////////
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: PerkDeckCard(cloneBuild,true),
            ),
          ),
          
          
          //////////////////////////// Save Buttons ////////////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                ////////// Discard ////////
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: kSecondaryColor)
                  ),
                  textColor: kSecondaryColor,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("DISCARD",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ),
                SizedBox(width: 100,),
                ////////// Save ////////
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: kSecondaryColor,
                  textColor: kTextOnSecondary,
                  child: Text("SAVE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    curntBuild.clone(cloneBuild);
                    curntBuild.setTitle(titleTF.controller.text);
                    if(!buildsList.contains(curntBuild)){
                      buildsList.add(curntBuild);
                    }
                    BuildsServices.writeToFile(buildsList);
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
      controller: TextEditingController(text: cloneBuild.getExportString())
    );

    //// Set up the buttons
    // Cancel button
    Widget cancelButton = FlatButton(
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: kSecondaryColor,
          width: 2
        ),
      ),
      textColor: kSecondaryColor,
      child: Text("CANCEL",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // Import button
    Widget importButton = FlatButton(
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      color: kSecondaryColor,
      textColor: kTextOnSecondary,
      child: Text("IMPORT", style: TextStyle(fontWeight: FontWeight.bold),),
      onPressed:  () {
        cloneBuild.importByString(stringTF.controller.text);
        Navigator.pop(context);
        setState(() {
          //refresh page after importing
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: kSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: Text("String of ${cloneBuild.getTitle()}"),
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

