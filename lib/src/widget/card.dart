import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/markdown_model.dart';
import '../page/mdialog.dart';

class CustomCard extends StatefulWidget {

  final MdModel md;

  const CustomCard({
    super.key,
    required this.md,

  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        //print('Pressed Card Title: ${widget.md.title}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MDialog(md:widget.md);
          },
        );
      },
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? Theme.of(context).primaryColor.withOpacity(0.5) : Colors.grey.withOpacity(0.1),
              blurRadius: _isHovered ? 4 : 2,
              offset: Offset(0, _isHovered ? 4 : 2),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      widget.md.topicImg ?? "assets/img/default.jpg",
                      fit: BoxFit.cover,
                      height: constraints.maxHeight * 0.5,
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Image.asset("assets/img/default.jpg",
                          fit: BoxFit.cover,
                          height: constraints.maxHeight * 0.5,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.md.title ?? "Read Error",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: constraints.maxHeight * 0.08,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          //SizedBox(height: constraints.maxHeight * 0.02),
                          // Text(
                          //   widget.md.subTitle ?? "Read Error",
                          //   style: TextStyle(fontSize: constraints.maxHeight * 0.06),
                          // ),
                          SizedBox(height: constraints.maxHeight * 0.02),
                          Text(
                            'Published: ${widget.md.date} By ${widget.md.author}',
                            style: TextStyle(color: Colors.grey, fontSize: constraints.maxHeight * 0.05),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
