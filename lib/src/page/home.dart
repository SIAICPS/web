import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popweb/src/page/404body.dart';
import '../model/markdown_model.dart';
import '../service/loadmd.dart';
import '../widget/mappbar.dart';
import '../widget/scrolltext.dart';
import 'mpage.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  int index = 0;
  void router(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //print(width);
    return Scaffold(
      appBar: MAppBar(
        nav: router,
        height: height * 0.1,
      ),
      body: Container(
        color: Colors.grey[100],
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: FutureBuilder(
                future: A.readmd(index),
                builder: (c, s) {
                  if (s.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (s.hasError) {
                    return Text('Error: ${s.error}');
                  } else if (!s.hasData || s.data == null) {
                    return Text('No data available');
                  } else {
                    return MPage(
                        index: index,
                        cardData: s.data ??
                            List.generate(10, (index) => MdModel.test()));
                  }
                },
              ),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          ),
        ),
      ),
      // bottomNavigationBar: HorizontalScrollingText(
      //   text: '本网站在国家自然科学基金委员会《关于新时代加强科学普及工作的意见》的指导下，依托国家自然科学基金重点项目《工业信息物理系统智能物联与综合安全》建立，力求让基础研究走进社会、让社会理解基础研究。',
      // ),
    );
  }
}

class A {
  static Future<List<MdModel>> readmd(int index) async {
    return await _loadMarkdownFiles(index);
  }

  static Future<List<MdModel>> _loadMarkdownFiles(int index) async {
    List<String> _fileNames = [];
    Map<String, String> _fileContents = {};
    List<MdModel> cardData = [];
    try {
      // Load file names from assets/md directory
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      final List<String> paths = manifestMap.keys
          .where(
              (String key) => key.startsWith('assets/${index.toString()}/'))
          .toList();
      int id = 0;
      // Extract file names from paths
      for (String path in paths) {
        if (!(path.endsWith(".md") || path.endsWith(".MD"))) {
          continue;
        }
        final String fileName = path.split('/').last;
        _fileNames.add(fileName);
        // Load file content
        final String fileContent = await rootBundle.loadString(path);
        _fileContents[fileName] = fileContent;

        List<Map<String, String>> mdmeta = parseHTMLComments(fileContent);
        for (var md in mdmeta) {
          cardData.add(MdModel(
              id: id++,
              title: md['title'],
              author: md['author'],
              date: md['published'],
              topicImg: md['topicImg'],
              content: extractContent(fileContent)));
        }
      }
    } catch (e) {
      print('Error loading markdown files: $e');
    }
    return cardData;
  }
}
