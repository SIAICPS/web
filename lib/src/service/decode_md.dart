
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as mdd;

import '../model/markdown_model.dart';
//
// var decodeMD = ({required MdModel md}) => FutureBuilder(
//   future: md.loadContent(),
//   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//     if (snapshot.hasData) {
//       return Markdown(
//         data: snapshot.data!,
//         extensionSet: mdd.ExtensionSet.gitHubWeb,
//         styleSheet: MarkdownStyleSheet(
//           h1Align: WrapAlignment.center,
//           h2Align: WrapAlignment.center,
//          h1: TextStyle(color: Theme.of(context).primaryColor),
//          h2: TextStyle(color: Theme.of(context).primaryColor),
//         ),
//         styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
//       );
//     } else if (snapshot.hasError) {
//       return const Center(
//         child: Text('Error loading Markdown'),
//       );
//     } else {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//   },
// );
//

class decodeMD extends StatelessWidget{
  const decodeMD({super.key,required this.md});
  final MdModel md;
  @override
  Widget build(BuildContext context) {
    return  Markdown(
      imageDirectory: "assets/",
      data: md.content ?? "'Error loading Markdown'",
      extensionSet: mdd.ExtensionSet.gitHubWeb,
      styleSheet: MarkdownStyleSheet(
        h1Align: WrapAlignment.center,
        h1: TextStyle(color: Theme.of(context).primaryColor,fontSize: 30),
        h2: TextStyle(color: Theme.of(context).primaryColor),
      ),
      styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
    );
  }

}

// var decodeMD1 = ({required MdModel md}) => Markdown(
//         data: md.content ?? "'Error loading Markdown'",
//         extensionSet: mdd.ExtensionSet.gitHubWeb,
//         styleSheet: MarkdownStyleSheet(
//           h1Align: WrapAlignment.center,
//           h2Align: WrapAlignment.center,
//           h1: TextStyle(color: Theme.of(context).primaryColor),
//           h2: TextStyle(color: Theme.of(context).primaryColor),
//         ),
//         styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
//       );
