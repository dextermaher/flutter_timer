import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:alarmclock/consts.dart';

class TimerTextField extends StatefulWidget {
  @override
  _TimerTextFieldState createState() => _TimerTextFieldState();
}

class _TimerTextFieldState extends State<TimerTextField> {
  AudioPlayer audioPlayer = AudioPlayer();
  int hTime;
  int mTime;
  int sTime;
  Duration text = Duration(seconds: 0);
  void startTimer(Duration duration) {
    bool isDone = false;
    DateTime startTime = DateTime.now();
    DateTime endTime = startTime.add(duration);
    Timer.periodic(Duration(seconds: 1), (timer) {
      display(startTime, endTime);
//      display(timeLeft);
      if (isDone) {
        timer.cancel();
      }
    });
    Timer(duration, () {
      isDone = true;
      play();
      print('hello');
    });
  }

  void display(DateTime startTime, DateTime endTime) {
    Duration timeLeft = endTime.difference(DateTime.now());
    setState(() {
      text = timeLeft;
    });
    print(timeLeft);
  }

  play() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Hours',
                    hintStyle: TextStyle(
                      color: kDarkTextColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kDarkTextColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kDarkTextColor),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    int updatedValue = int.tryParse(value);
                    setState(() {
                      hTime = updatedValue;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Minutes',
                    hintStyle: TextStyle(
                      color: kDarkTextColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kDarkTextColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kDarkTextColor),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    int updatedValue = int.tryParse(value);
                    setState(() {
                      mTime = updatedValue;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Seconds',
                    hintStyle: TextStyle(
                      color: kDarkTextColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kDarkTextColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kDarkTextColor),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    int updatedValue = int.tryParse(value);
                    setState(() {
                      sTime = updatedValue;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text(
              'Enter',
              style: TextStyle(color: kTextColor),
            ),
            color: kButtonColor,
            onPressed: () {
              startTimer(Duration(
                  hours: hTime != null ? hTime : 0,
                  minutes: mTime != null ? mTime : 0,
                  seconds: sTime != null ? sTime : 0));
            },
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            decoration: BoxDecoration(
              color: kHighlightColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(20),
            child: Text(
              '${text.inHours <= 9 ? 0 : ''}${text.inHours}:${text.inMinutes - text.inHours * 60 <= 9 ? 0 : ''}${text.inMinutes - text.inHours * 60}:${text.inSeconds - text.inHours * 60 - text.inMinutes * 60 <= 9 ? 0 : ''}${text.inSeconds - text.inHours * 60 - text.inMinutes * 60}',
              style: TextStyle(
                fontSize: 50,
                color: kDarkTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
