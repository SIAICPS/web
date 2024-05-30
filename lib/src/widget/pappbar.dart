
import 'package:flutter/material.dart';

class PAppBar extends StatelessWidget implements PreferredSizeWidget {
  PAppBar({super.key,required this.onButtonClick,required this.title});
  String title;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final Function onButtonClick;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white60,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                onButtonClick(false);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back),
                  Text("上一页"),
                ],
              )
          ),
          Text(
            title,
            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
          ),
          TextButton(
            onPressed: () {
              onButtonClick(true);
            },
            child: Row(
              children: [
                Text("下一页"),
                Icon(Icons.arrow_forward),
              ],
            )
          ),
        ],
      ),
    );
  }
}
