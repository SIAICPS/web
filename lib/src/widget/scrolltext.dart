



import 'dart:async';
import 'package:flutter/cupertino.dart';

class HorizontalScrollingText extends StatefulWidget {
  const HorizontalScrollingText({super.key,required this.text});
  final String text;
  @override
  _HorizontalScrollingTextState createState() => _HorizontalScrollingTextState();
}

class _HorizontalScrollingTextState extends State<HorizontalScrollingText> {

  ScrollController _scrollController = ScrollController();
  bool _forward = true;

  @override
  void initState() {
    super.initState();
    _scrollText();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Text(widget.text,
        style: TextStyle(letterSpacing: 3),
      ),
    );
  }

  void _scrollText() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_scrollController.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double pixels = _scrollController.position.pixels;
        if (_forward && pixels < maxScrollExtent) {
          _scrollController.animateTo(
            maxScrollExtent,
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        } else if (_forward) {
          _forward = false;
        } else if (!_forward && pixels > 0) {
          _scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        } else if (!_forward) {
          _forward = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
