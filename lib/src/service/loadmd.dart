import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../model/markdown_model.dart';


const Map<int,String> navigator ={
  0:'首页',
  1:'工业软件',
  2:'工业网络',
  3:'工业安全',
  4:'感知和自动控制',
  5:'工业云和智能服务平台',
  6:'应用案例',
};

const Map<int,List<MdModel>> mdModelMap = {
  0:[],
  1:[],
  2:[],
  3:[],
  4:[],
  5:[],
  6:[],
};



Future<void> load_all(int count) async {
  int id=0;
  for(int i=0;i<=count;i++){
    List<String> t = await _loadAssets(i);
    for(var filepath in t){
      if(!(filepath.endsWith(".md")||filepath.endsWith(".MD"))){
        continue;
      }
      String fileContent = await readFileContent(filepath);
      List<Map<String, String>> mdmeta = parseHTMLComments(fileContent);
      for (var md in mdmeta) {
        mdModelMap[i]?.add(MdModel(
            id: id++,
            title: md['title'],
            author: md['author'],
            date: md['published'],
            topicImg: md['topicImg'],
            content:extractContent(fileContent)
        ));
      }
    }
  }
  print("load_all");
}

Future<String> readFileContent(String filePath) async {
  return await rootBundle.loadString(filePath);
}

List<Map<String, String>> parseHTMLComments(String content) {
  List<Map<String, String>> comments = [];
  RegExp exp = RegExp(r'<!--(.*?)-->', multiLine: true, dotAll: true);
  Iterable<RegExpMatch> matches = exp.allMatches(content);
  for (RegExpMatch match in matches) {
    String? commentContent = match.group(1)?.trim();
    if (commentContent != null && commentContent.isNotEmpty) {
      Map<String, String> commentMap = {};
      List<String> lines = commentContent.split('\n');
      for (String line in lines) {
        if(line.startsWith("topicImg:")){
          commentMap["topicImg"] = line.substring("topicImg:".length,line.length).trim();
        }
        List<String> parts = line.split(':');
        if (parts.length == 2) {
          String key = parts[0].trim();
          String value = parts[1].trim();
          commentMap[key] = value;
        }
      }
      comments.add(commentMap);
    }
  }
  return comments;
}

String extractContent(String fileContent) {
  RegExp exp = RegExp(r'<!--.*?-->(.*)', multiLine: true, dotAll: true);
  Match? match = exp.firstMatch(fileContent);
  return match?.group(1)?.trim() ?? '';
}



Future<List<String>> _loadAssets(int count) async {
  List<String> assetFiles = [];
  final manifestContent =
    await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  for (String key in manifestMap.keys) {
    if (key.startsWith('assets/${count.toString()}/')) {
      assetFiles.add(key);
    }
  }
  if(assetFiles.isEmpty){assetFiles.add("assets/example.md");}
  return assetFiles;
}