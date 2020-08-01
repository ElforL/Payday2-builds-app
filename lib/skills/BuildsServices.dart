import 'dart:convert';  //line 14

import 'package:flutter/services.dart' show rootBundle; //line 9
import 'package:pd2_builds/skills/Build.dart';

class BuildsServices {

  static Future<String> _loadABuildAsset() async{
    return await rootBundle.loadString('docs/builds.json');
  }

  static Future<List<Build>> loadBuilds() async {
    String jsonString = await _loadABuildAsset();
    final jsonResponse = json.decode(jsonString);
    List<Build> builds = jsonResponse.map((i) => Build.fromJson(i)).toList();
    return builds;
  }
}
