import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/markdown_model.dart';
import '../page/mdialog.dart';

class PicFlat extends StatefulWidget {
  const PicFlat({super.key, required this.mds});

  final List<MdModel> mds;

  @override
  _PicFlatState createState() => _PicFlatState();
}

class _PicFlatState extends State<PicFlat> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              //height: MediaQuery.of(context).size.height * 0.8,
              height: 220,
              aspectRatio: 16 / 9,
              //viewportFraction: 0.8,
              initialPage: _currentIndex,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.mds.map((md) {
              return Builder(
                builder: (BuildContext context) {
                  return _SinglePic(
                    md: md,
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.mds.length, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentIndex == index ? Theme.of(context).primaryColor : Colors.grey,
                ),
              );
            }),
          ),
        ],
    );
  }
}

class _SinglePic extends StatefulWidget {
  final MdModel md;

  const _SinglePic({super.key, required this.md});

  @override
  State<StatefulWidget> createState() {
    return _SinglePicState();
  }
}

class _SinglePicState extends State<_SinglePic> {
  bool _onHover = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.95,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return MDialog(md: widget.md);
            },
          );
        },
        onHover: (flag) {
          setState(() {
            _onHover = flag;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: _onHover ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.grey.withOpacity(0.1),
                offset: const Offset(0.0, 0.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(widget.md.topicImg ?? "assets/img/default.jpg",),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _onHover ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.grey.withOpacity(0.1),
                        offset: const Offset(0.0, 0.0),
                        blurRadius: _onHover ? 6.0 : 2.0,
                      ),
                    ]),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    widget.md.title ?? "Read Error",
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
