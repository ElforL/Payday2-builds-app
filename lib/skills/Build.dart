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

  void clone(Build source){
    this._title = source.getTitle();
    this._spentPnts = source.getSpentPnts();
    this._availablePnts = source.getAvailablePnts();
    this._perk = source.getPerk();
    this._subtrees = new List<Subtree>(15);
    for (var i = 0; i < this._subtrees.length; i++) {
      this._subtrees[i] = Subtree.clone(source._subtrees[i]);
    }
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
    List<String> splits = string.split(":");
    const chars = ['m','e','t','g','f','p'];
    const optionsChar = [
      ['f','d','e','b','c','a'],
      ['l','j','k','h','i','g'],
      ['r','p','q','n','o','m']
    ];
    const perksNames = [
      'Crew Chief',
      'Muscle',
      'Armorer',
      'Rogue',
      'Hitman',
      'Crook',
      'Burglar',
      'Infiltrator',
      'Sociopath',
      'Gambler',
      'Grinder',
      'Yakuza',
      'Ex-President',//
      'Maniac',
      'Anarchist',
      'Biker',
      'Kingpin',
      'Sicario',
      'Stoic',
      'Tag Team',
      'Hacker',
    ];
    const perksChar = [
      'C', // Crew Chief
      'M', // Muscle
      'A', // Armorer
      'R', // Rogue
      'H', // Hitman
      'O', // Crook
      'B', // Burglar
      'I', // Inflitrator
      'S', // Sociopath
      'G', // Gambler
      'N', // Grinder
      'Y', // Yakuza
      'E', // Ex-President
      '1', // Maniac
      'T', // Anarchist
      'K', // Biker
      'P', // Kingpin
      '2', // Sicario
      '3', // Stoic
      '4', // Tag Team
      '5', // Hacker
    ];
    
    
    for (var i = 0; i < splits.length; i++) {
      int subIndex, treeIndex = chars.indexOf(splits[i][0]);
      if(treeIndex == -1) continue;
      
      
      if(splits[i][0] == 'p'){
        int perkIndx = perksChar.indexOf(splits[i][1]);
        if(perkIndx == -1) {
          _perk = "Crew Chief";
        }else {
          _perk = perksNames[perkIndx];
        }
        continue;
      }

      // r/badcode :)
      for (var j = 1; j < splits[i].length; j++) {
        if(optionsChar[0].contains(splits[i][j].toLowerCase())){
          subIndex = 0;
        }else if(optionsChar[1].contains(splits[i][j].toLowerCase())){
          subIndex = 1;
        }else if(optionsChar[2].contains(splits[i][j].toLowerCase())){
          subIndex = 2;
        }else{
          continue;
        }
        
        _subtrees[3*treeIndex+subIndex].getOptions()[optionsChar[subIndex].indexOf(splits[i][j].toLowerCase())] = !isUppercase(splits[i][j])? 1: 2;
      }
    }
    calcPoints();
  } // importByString

  String getExportString(){
    String string = "";
    List<bool> treeUsed = [false,false,false,false,false];
    const treeChar = ['m','e','t','g','f'];
    const optionsChar = [
      ['f','d','e','b','c','a'],
      ['l','j','k','h','i','g'],
      ['r','p','q','n','o','m']
    ];
    const perksNames = [
      'Crew Chief',
      'Muscle',
      'Armorer',
      'Rogue',
      'Hitman',
      'Crook',
      'Burglar',
      'Infiltrator',
      'Sociopath',
      'Gambler',
      'Grinder',
      'Yakuza',
      'Ex-President',//
      'Maniac',
      'Anarchist',
      'Biker',
      'Kingpin',
      'Sicario',
      'Stoic',
      'Tag Team',
      'Hacker',
      ];
    const perksChar = [
      'C', // Crew Chief
      'M', // Muscle
      'A', // Armorer
      'R', // Rogue
      'H', // Hitman
      'O', // Crook
      'B', // Burglar
      'I', // Inflitrator
      'S', // Sociopath
      'G', // Gambler
      'N', // Grinder
      'Y', // Yakuza
      'E', // Ex-President
      '1', // Maniac
      'T', // Anarchist
      'K', // Biker
      'P', // Kingpin
      '2', // Sicario
      '3', // Stoic
      '4', // Tag Team
      '5', // Hacker
      ];

    if(getSpentPnts() == 0) return "ibcdea:p${perksChar[perksNames.indexOf(_perk)]}8";

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

    // when the fugitive tree is used there's no : after it and I cbb to fix it in the loop tbh
    if(string[string.length-1] != ":") string += ":";

    //full infamy
    string += "ibcdea"; 

    //perkdeck
    string += ":p";      
    string += perksChar[perksNames.indexOf(_perk)]+"8";

    return string;
  } //getExportString

  bool isUppercase(String str) {
    return str == str.toUpperCase();
  }

}