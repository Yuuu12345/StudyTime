import 'package:flutter/material.dart';
import 'package:studytime/stopwatch.dart';
import 'package:studytime/timer.dart';

void main() {
  runApp(const selectApp());
}

class selectApp extends StatelessWidget {
  const selectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('記録形式')),
        body: Center(
            child: Column(
          children: [
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StopwatchScreen()));
                },
                child: const Text('ストップウォッチ')),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TimerScreen()));
                },
                child: const Text('タイマー')),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StopwatchScreen()));
                },
                child: const Text('手動')),
            Spacer()
          ],
        )));
  }
}
