import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'Build.dart';

class BuildsServices {

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/builds.json');
  }

  static Future<File> writeToFile(List<Build> builds) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString(jsonEncode(builds));
  }
  
  static Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return null.
      return null;
    }
  }

  static Future<List<Build>> loadBuilds() async {
    String jsonString = await readFile();
    final jsonResponse = json.decode(jsonString);
    List<Build> builds = List<Build>.from(jsonResponse.map((i) => Build.fromJson(i)).toList());
    return builds;
  }
}
