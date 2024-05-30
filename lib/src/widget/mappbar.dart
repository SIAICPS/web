import 'dart:js';

import 'package:flutter/material.dart';

import '../model/markdown_model.dart';
import '../page/mdialog.dart';
import '../service/loadmd.dart';
import '../service/viewcount.dart';

class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  MAppBar(
      {super.key,
      this.height = 150,
      this.background = "assets/img/default.jpg",
      required this.nav});

  double height;
  final String background;
  final Function nav;

  @override
  Size get preferredSize => Size.fromHeight(height);

  //List<String> routerTitle = ['工业软件','工业网络','工业安全','感知和自动控制','工业云和智能服务平台','应用案例'];
  @override
  Widget build(BuildContext context) {
    var Sheight = MediaQuery.of(context).size.height;
    var Swidth = MediaQuery.of(context).size.width;
    bool isWide = Swidth > 600;
    return isWide
        ? PreferredSize(
            preferredSize: preferredSize,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  foregroundDecoration:
                      const BoxDecoration(color: Color(0x99000000)),
                  child: Image.asset(
                    background,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  top: 10,
                  left: 30,
                  child: Center(
                    child: Text(
                      "ICPS",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 2)
                          ]),
                    ),
                  ),
                ),
                Positioned(
                  top: -5,
                  //bottom: 0,
                  left: 0,
                  right: 10,
                  child: Transform.scale(
                    scaleX: 1.6,
                    scaleY: 0.85,
                    child: Column(
                      children: [
                        SelectableText(
                          "工业信息物理系统科普网",
                          style: TextStyle(
                              fontSize: height * 0.50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        //SelectableText("GongYeXinXiWuLiXiTongKePuWang",style: TextStyle(fontSize: height * 0.2,color: Colors.grey),),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: height * 0.4,
                    child: Column(children: [
                      SelectableText(
                        "Industrial Cyber-Physical Systems",
                        style: TextStyle(
                            fontSize: height * 0.2, color: Colors.grey),
                      ),
                    ]),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    //left: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        //border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0x99000000),
                      ),
                      height: height * 0.5,
                      child: Row(
                        children: List.generate(
                            navigator.length,
                            (index) => TextButton(
                                  onPressed: () {
                                    nav(index);
                                  },
                                  child: Text(navigator[index]!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          shadows: [
                                            Shadow(
                                                offset: Offset(1, 1),
                                                blurRadius: 0.5,
                                                color: Colors.black)
                                          ])),
                                )).toList()
                          ..add(
                            _aboutpage(context,Swidth,Sheight)
                          ),
                      ),
                    )),
                Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                        height: height * 0.5,
                        width: 150,
                        decoration: const BoxDecoration(
                          //border: Border.all(),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color(0x22FFFFFF),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "访问总数:",
                                style: const TextStyle(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          offset: Offset(1, 1),
                                          blurRadius: 0.5,
                                          color: Colors.black)
                                    ]),
                              ),
                              getViews(id: "all"),
                            ],
                          ),
                        ))),
              ],
            ),
          )
        : PreferredSize(
            preferredSize: preferredSize,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  foregroundDecoration:
                      const BoxDecoration(color: Color(0x99000000)),
                  child: Image.asset(
                    background,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: -5,
                  //bottom: 0,
                  left: 0,
                  right: 10,
                  child: Transform.scale(
                    scaleX: 1.6,
                    scaleY: 0.85,
                    child: Column(
                      children: [
                        SelectableText(
                          "ICPS科普",
                          style: TextStyle(
                              fontSize: height * 0.50,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        //SelectableText("GongYeXinXiWuLiXiTongKePuWang",style: TextStyle(fontSize: height * 0.2,color: Colors.grey),),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: height * 0.4,
                    child: Column(children: [
                      SelectableText(
                        "Industrial Cyber-Physical Systems",
                        style: TextStyle(
                            fontSize: height * 0.2, color: Colors.grey),
                      ),
                    ]),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    //left: 0,
                    child: TextButton(
                        onPressed: () {
                          showMenu(
                            context: context,
                            color: Colors.black87,
                            position: RelativeRect.fromLTRB(
                              MediaQuery.of(context).size.width - 50.0,
                              kToolbarHeight,
                              0.0,
                              0.0,
                            ),
                            items: List.generate(
                                navigator.length,
                                (index) => PopupMenuItem(
                                  onTap: () {
                                    nav(index);
                                  },
                                      child: TextButton(
                                        onPressed: () {
                                          nav(index);
                                        },
                                        child: Text(navigator[index]!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                shadows: [
                                                  Shadow(
                                                      offset: Offset(1, 1),
                                                      blurRadius: 0.5,
                                                      color: Colors.black)
                                                ])),
                                      ),
                                    )).toList()
                              ..add(PopupMenuItem(
                                child: _aboutpage(context,Swidth,Sheight)
                              )),
                          );
                        },
                        child: Text("导航"))),
                Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                        height: height * 0.5,
                        width: 150,
                        decoration: const BoxDecoration(
                          //border: Border.all(),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color(0x22FFFFFF),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "V:",
                                style: const TextStyle(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          offset: Offset(1, 1),
                                          blurRadius: 0.5,
                                          color: Colors.black)
                                    ]),
                              ),
                              getViews(id: "all"),
                            ],
                          ),
                        ))),
              ],
            ),
          );
  }
}



Function _aboutpage = (BuildContext context,double Swidth,double Sheight) => TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: SizedBox(
                                            width: Swidth * 0.8,
                                            height: Sheight * 0.8,
                                            child: Scaffold(
                                              appBar: AppBar(
                                                title: Text("关于"),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                              ),
                                              body: Center(
                                                child: SingleChildScrollView(
                                                  child: Container(
                                                    width: Swidth * 0.7,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '   \t本网站在国家自然科学基金委员会《关于新时代加强科学普及工作的意见》的指导下，依托国家自然科学基金重点项目《工业信息物理系统智能物联与综合安全》建立，力求让基础研究走进社会、让社会理解基础研究。',
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 50,
                                                          ),
                                                        ),
                                                        Text(
                                                          "x",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "关于本站",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                );