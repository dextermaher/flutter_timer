import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alarmclock/consts.dart';

class Clock extends StatelessWidget {
  final dateString;
  Clock({this.dateString = 5});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: kDarkHighlightColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Text(
            '$dateString',
            style: TextStyle(
              color: kTextColor,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
