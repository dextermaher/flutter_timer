import 'package:alarmclock/screens/clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../logic/timer_text_field.dart';
import 'package:alarmclock/consts.dart';
import 'package:alarmclock/screens/time_input.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var ourTime = DateFormat('h:mm:ss a').format(DateTime.now());
  bool isTimerRunning = false;
  @override
  Widget build(BuildContext context) {
    updater();
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Clock(
                  dateString: ourTime,
                ),
              ),
              Expanded(
                child: InputHandler(),
              ),
            ],
          ),
        ));
  }

  void updater() {
    if (!isTimerRunning) {
      const duration = const Duration(seconds: 1);
      Timer.periodic(
        duration,
        (Timer t) => stateSetter(),
      );
    } else {
      stateSetter();
    }
  }

  void stateSetter() {
    setState(() {
      ourTime = DateFormat('h:mm:ss a').format(DateTime.now());
      isTimerRunning = true;
    });
  }
}
