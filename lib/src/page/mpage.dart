
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:popweb/src/model/markdown_model.dart';
import 'package:popweb/src/widget/pappbar.dart';
import 'package:popweb/src/widget/picflat.dart';

import '../service/loadmd.dart';
import '../widget/card.dart';

class MPage extends StatefulWidget {
  MPage({super.key,required this.index,required this.cardData});
  int index;
  List<MdModel> cardData;
  @override
  _CardListPageState createState() => _CardListPageState();
}

class _CardListPageState extends State<MPage> {
  //List<MdModel> cardData = List.generate(201, (index) => MdModel.test(id:index,title: (index+1).toString()));
  //List<MdModel> cardData =[];// mdModelMap[1] ?? List.generate(10, (index) => MdModel.test(id:index,title: (index+1).toString()));
  _CardListPageState(){
    //totalPageCount = (widget.cardData.length /(rows*columns) +1.0).toInt();
  }
  int rows = 4;
  int columns = 2;
  double cardWidth = 5;
  double cardHeight = 6;
  late int totalPageCount;
  int pageIndex = 0;

  //true you false zuo
  void clickAppBarButton(bool LR){
    totalPageCount = (widget.cardData.length /(rows*columns) +1.0).toInt();
    setState(() {
      if(!LR){
        pageIndex--;
        if(pageIndex<0){
          pageIndex=0;
        }
      }else {
        pageIndex++;
        if (pageIndex >= totalPageCount-1) {
          pageIndex = totalPageCount-1;
        }
      }
    });

  }

  List<MdModel> getCurrentPageCards() {
    int startIndex = pageIndex * (rows * columns);
    int endIndex = (pageIndex + 1) * (rows * columns);
    if (endIndex > widget.cardData.length) endIndex = widget.cardData.length;
    return widget.cardData.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.index);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    width>800?columns=4:columns=2;
    return Scaffold(
      //appBar: PAppBar(onButtonClick:clickAppBarButton, title: navigator[widget.index] ?? "读取异常",),
      body: SingleChildScrollView(
        child:  Column(
          children: [
            PicFlat(mds: widget.cardData.length>3 ? widget.cardData.sublist(0,3) :widget.cardData,),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: columns,
              childAspectRatio: cardWidth / cardHeight,
              children: getCurrentPageCards().map((card) {
                //return CustomCard(md: card,);
                return FractionallySizedBox(
                  widthFactor: 0.95,
                  heightFactor: 0.95,
                  child: CustomCard(md: card,),
                );
              }).toList(),
            ),
          ],
        ),
      )

    );
  }








}
