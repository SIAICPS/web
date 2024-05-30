


import 'package:flutter/material.dart';

import '../model/markdown_model.dart';
import '../service/decode_md.dart';
import '../service/md5.dart';
import '../service/viewcount.dart';

class MDialog extends StatelessWidget {
  const MDialog({super.key, required this.md, });

  final MdModel md;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.8,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(md.title ?? "Read Error"),
            //automaticallyImplyLeading: false,
            actions: [
              const Text("阅读量:"),
              getViews(id:calculateMD5(md.title??"all").substring(0,6)),
              const SizedBox(width: 10,)
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height*0.9,
            width: MediaQuery.of(context).size.width*0.9,
            child: decodeMD(md:md),
          ),
        ),
      ),
    );
  }
}