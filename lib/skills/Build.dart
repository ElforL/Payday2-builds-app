import 'package:pd2_builds/skills/Subtree.dart';

class Build {
  List<Subtree> _subtrees;
  int _spentPnts;
  int _availablePnts;

  Build(){
    _subtrees = new List<Subtree>(15);
    _spentPnts = 0;
    _availablePnts = 120;

    for (var i = 0; i < _subtrees.length; i++) {
      _subtrees[i] = new Subtree();
    }
  }//close constructor

  List<Subtree> getSubTrees(){
    return _subtrees;
  }
  int getSpentPnts(){
    return _spentPnts;
  }
  int getAvailablePnts(){
    return _availablePnts;
  }

  bool upgradeOption(int subtreeNum, int opNum){
    bool res = _subtrees[subtreeNum-1].upgradeOption(opNum, _availablePnts);
    calcPoints();
    return res;
  }

  void calcPoints(){
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

  String getExportString(){
    String string = "";
    bool commaNeeded = false;
    List<String> optionsChar = ['a','b','c','d','e','f'];

    for (int i = 0; i < _subtrees.length; i++) {
      if(_subtrees[i].getSpentPnts() > 0){
        string += i.toString()+":";
        for (int j = 0; j < _subtrees[i].getOptions().length; j++) {
          List<int> options = _subtrees[i].getOptions();

          if (options[j] == 1){
            string += commaNeeded? ","+optionsChar[j]: optionsChar[j];
            commaNeeded = true;
          }else if(options[j] == 2){
            string += commaNeeded? ","+optionsChar[j].toUpperCase() : optionsChar[j].toUpperCase();
            commaNeeded = true;
          }
            
        }
        commaNeeded = false;
        string += ";";
      }
    }

    return string;
  }

}