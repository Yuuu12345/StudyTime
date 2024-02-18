import 'package:flutter/material.dart';
import 'package:studytime/manual.dart';
import 'package:studytime/stopwatch.dart';
import 'package:studytime/timer.dart';

class selectApp extends StatelessWidget {

  final String docId; // この行でselectedButtonを定義

  // コンストラクタでselectedButtonを受け取る
  const selectApp({Key? key, required this.docId}) : super(key: key);
  // const selectApp({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('記録形式'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StopwatchScreen(docId: docId),
                  ),
                );
              },
              child: const Text('ストップウォッチ'),
            ),
            SizedBox(height: 20),
            ElevatedButton(

                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TimerScreen(docId: docId)));
                },
                child: const Text('タイマー')),
            SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimeRangePickerScreen(docId: docId),
                  ),
                );
              },
              child: const Text('手動'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
