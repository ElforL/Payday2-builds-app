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
}