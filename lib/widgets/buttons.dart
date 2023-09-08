import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xo_app/constants.dart';

// ignore: must_be_immutable
class Buttons extends StatelessWidget {
  Buttons(
      {super.key,
      required this.symbols,
      required this.onClick,
      required this.index,
      required this.symbolColor});
  String symbols;
  Function(int) onClick;
  int index;
  Color symbolColor;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Color(0xFF56627E),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: kSecondColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () {
            onClick(index);
          },
          child: Text(
            symbols,
            style: TextStyle(
              fontSize: 100,
              color: symbolColor,
            ),
          ),
        ));
  }
}
