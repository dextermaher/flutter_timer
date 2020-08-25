import 'dart:async';

import 'package:flutter/material.dart';
import 'package:alarmclock/consts.dart';
import 'package:alarmclock/logic/timer_text_field.dart';

class InputHandler extends StatefulWidget {
  @override
  _InputHandler createState() => _InputHandler();
}

class _InputHandler extends State<InputHandler> {
  int hTime;
  int mTime;
  int sTime;
  List displays = [];
  bool shouldRun = false;

  TimerTextField countDownDisplay;
  TextField textField(String hintText, Function onChangeCallback) {
    return TextField(
      decoration: InputDecoration(
        hintText: '$hintText',
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
        onChangeCallback(value);
      },
    );
  }

  TimerTextField timerTextField([duration]) {
    return TimerTextField(
      duration: duration == null ? 0 : duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: textField('Hours', (value) {
                    int updatedValue = int.tryParse(value);
                    setState(() {
                      hTime = updatedValue;
                    });
                  }),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: textField('Minutes', (value) {
                    int updatedValue = int.tryParse(value);
                    setState(() {
                      mTime = updatedValue;
                    });
                  }),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: textField('Seconds', (value) {
                    int updatedValue = int.tryParse(value);
                    setState(() {
                      sTime = updatedValue;
                    });
                  }),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          FlatButton(
            child: Text(
              'Enter',
              style: TextStyle(color: kTextColor),
            ),
            color: kButtonColor,
            onPressed: () {
              setState(() {
                shouldRun = true;
                if (shouldRun == true) {
                  countDownDisplay = TimerTextField(
                    duration: Duration(
                        hours: hTime == null ? 0 : hTime,
                        minutes: mTime == null ? 0 : mTime,
                        seconds: sTime == null ? 0 : sTime),
                  );
                  //shouldRun = false;
                }
              });
              Timer(
                  Duration(
                      hours: hTime == null ? 0 : hTime,
                      minutes: mTime == null ? 0 : mTime,
                      seconds: sTime == null ? 0 + 1 : sTime + 1), () {
                setState(() {
                  shouldRun = false;
                });
              });
//              print(
//                  '${hTime == null ? 0 : hTime}&${mTime == null ? 0 : mTime}&${sTime == null ? 0 : sTime}');
            },
          ),
          Container(
            child: shouldRun ? countDownDisplay : null,
          )
        ],
      ),
    );
  }
}
