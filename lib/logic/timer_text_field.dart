import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:alarmclock/consts.dart';

class TimerTextField extends StatefulWidget {
  final Duration duration;
  TimerTextField({this.duration}) {
    print('received 0');
  }

  @override
  _TimerTextFieldState createState() => _TimerTextFieldState();
}

class _TimerTextFieldState extends State<TimerTextField> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration text = Duration(seconds: 0);
  bool isDone = false;
  bool isHappening = false;

  void startTimer(Duration duration) {
    if (!isHappening) {
      setState(() {
        isHappening = true;
      });
      DateTime startTime = DateTime.now();
      DateTime endTime = startTime.add(duration);
      Timer.periodic(Duration(seconds: 1), (timer) {
        display(startTime, endTime);
        if (isDone) {
          timer.cancel();
        }
      });
      Timer(duration, () {
        setState(() {
          isDone = true;
          isHappening = false;
        });
        play();
        //super.dispose();
      });
    }
  }

  void display(DateTime startTime, DateTime endTime) {
    Duration timeLeft = endTime.difference(DateTime.now());
    setState(() {
      text = timeLeft;
    });
  }

  play() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
    );
  }

  @override
  Widget build(BuildContext context) {
    startTimer(widget.duration);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
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
    );
  }
}
