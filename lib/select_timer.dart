import 'package:flutter/material.dart';
import 'package:studytime/stopwatch.dart';
import 'package:studytime/timer.dart';

void main() {
  runApp(selectApp());
}

class selectApp extends StatelessWidget {
  const selectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Row(
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StopwatchScreen()));
            },
            child: Text('ストップウォッチ')),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TimerApp()));
            },
            child: Text('タイマー')),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StopwatchScreen()));
            },
            child: Text('手動'))
      ],
    )));
  }
}
