import 'package:flutter/material.dart';
import 'package:FlutStamp/constants.dart';

class MenuItemCard extends StatelessWidget {
  MenuItemCard({this.menuText, this.screen});

  final String menuText;
  final screen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return screen;
            },
          ),
        );
      },
      child: Container(
        child: Center(
          child: Text(
            menuText,
            style: kMenuTextStyle,
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(vertical: 17.0),
        decoration: BoxDecoration(
          color: Color(0xff00b347),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
