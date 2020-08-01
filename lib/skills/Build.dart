import 'package:pd2_builds/skills/Subtree.dart';

class Build {
  String _title;
  List<Subtree> _subtrees;
  int _spentPnts;
  int _availablePnts;
  String _perk;

  Build(String title){
    this._title = title;
    _subtrees = new List<Subtree>(15);
    _spentPnts = 0;
    _availablePnts = 120;
    _perk = "Crew Chief";

    for (var i = 0; i < _subtrees.length; i++) {
      _subtrees[i] = new Subtree();
    }
  }

  Build.fromJson(Map<String, dynamic> map){
    _title = map['title'];
    _spentPnts = map['spentPnts'];
    _availablePnts = map['availablePnts'];
    _perk = map['perk'];
    
    var subtreesFromMap = map['subtrees'] as List;
    _subtrees = subtreesFromMap.map((e) => Subtree.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson(){
    return <String, dynamic>{
      'title': _title,
      'spentPnts': _spentPnts,
      'availablePnts': _availablePnts,
      'perk': _perk,
      'subtrees': [
        for (var item in _subtrees) 
          item.toJson()
      ]
    };
  }

  String getPerk(){return _perk;}
  
  String getTitle(){
    return _title;
  }
  List<Subtree> getSubTrees(){
    return _subtrees;
  }
  int getSpentPnts(){
    return _spentPnts;
  }
  int getAvailablePnts(){
    return _availablePnts;
  }

  void setPerk(String newPerk){
    this._perk = newPerk;
  }

  setTitle(String title) => this._title = title;

  bool upgradeOption(int subtreeNum, int opNum){
    bool res = _subtrees[subtreeNum-1].upgradeOption(opNum, _availablePnts);
    calcPoints();
    return res;
  }

  bool degradeOption(int subtreeNum, int opNum){
    bool res = _subtrees[subtreeNum-1].degradeOption(opNum);
    calcPoints();
    return res;
  }

  void calcPoints(){
    calcTotalSpentPoints();
    _availablePnts = 120 - _spentPnts;
  }

  void calcTotalSpentPoints(){
    int sum = 0;
    for (var subtree in _subtrees) {
      sum += subtree.getSpentPnts();
    }
    _spentPnts = sum;
  }

  void resetTree(int treeNum){
    _subtrees[treeNum].resetTree();
    calcPoints();
  }

  void resetAllTrees(){
    for (var i = 0; i < _subtrees.length; i++) {
      _subtrees[i].resetTree();
    }
    calcPoints();
  }

  void load(){
    
  }

  void importByString(String string){

  }

  String getExportString(){
    String string = "";
    List<bool> treeUsed = [false,false,false,false,false];
    final treeChar = ['m','e','t','g','f'];
    final optionsChar = [
      ['f','d','e','b','c','a'],
      ['l','j','k','h','i','g'],
      ['r','p','q','n','o','m']
    ];
    final perksNames = 
      ['Crew Chief',
      'Muscle',
      'Armorer',
      'Rogue',
      'Hitman',
      'Crook',
      'Burglar',
      'Infiltrator',
      'Sociopath',
      'Grinder',
      'Yakuza',
      'Ex-President'];
    final perksChar = 
      ['C',
      'M',
      'A',
      'R',
      'H',
      'O',
      'B',
      'I',
      'S',
      'N',
      'Y',
      'E'];

    //iterate through every subtree
    for (int i = 0; i < _subtrees.length; i++) {
      //adds : after trees 
      if(i % 3 == 0 && i != 0 && treeUsed[(i ~/ 3)-1]) string += ':';

      //if the subtree is empty then skip
      if(_subtrees[i].getSpentPnts() == 0) continue;

      //checks if the tree already been added to the string (to avoid inserting the treeChar multiple times)
      // if not: insert the treeChar and set it to used
      if(!treeUsed[i ~/ 3]){
        treeUsed[i ~/ 3] = true;
        string += treeChar[i ~/ 3];
      }

      for (int j = 0; j < _subtrees[j].getOptions().length; j++) {
        List<int> options = _subtrees[i].getOptions();

        if (options[j] == 1){
          string += optionsChar[i % 3][j];
        }else if(options[j] == 2){
          string += optionsChar[i % 3][j].toUpperCase();
        }
      }
    }

    //full infamy
    string += "ibcdea"; 

    //perkdeck
    string += ":p";      
    string += perksChar[perksNames.indexOf(_perk)]+"8";

    return string;
  }

  /* String getExportString(){
    String string = "";
    bool commaNeeded = false;
    List<String> optionsChar = ['a','b','c','d','e','f'];

    for (int i = 0; i < _subtrees.length; i++) {
      if(_subtrees[i].getSpentPnts() > 0){
        string += i.toString()+":";
        for (int j = 0; j < _subtrees[i].getOptions().length; j++) {
          List<int> options = _subtrees[i].getOptions();

          if (options[j] == 1){
            // string += commaNeeded? ","+optionsChar[j]: optionsChar[j];
            string += optionsChar[j];
            commaNeeded = true;
          }else if(options[j] == 2){
            // string += commaNeeded? ","+optionsChar[j].toUpperCase() : optionsChar[j].toUpperCase();
            string += optionsChar[j].toUpperCase();
            commaNeeded = true;
          }
            
        }
        commaNeeded = false;
        string += ";";
      }
    }

    return string;
  } */

}