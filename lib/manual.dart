import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studytime/main.dart';

class TimeRangePicker extends StatelessWidget {
  // const TimeRangePicker({Key? key}) : super(key: key);
  final String? docId; // nullableにすることもできる

  const TimeRangePicker({Key? key, this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manual App',
      home: TimeRangePickerScreen(docId: docId!),
    );
  }
}

class TimeRangePickerScreen extends StatefulWidget {
  // const TimeRangePickerScreen({Key? key}) : super(key: key);
  final String docId; // この行でselectedButtonを定義

  // コンストラクタでselectedButtonを受け取る
  const TimeRangePickerScreen({Key? key, required this.docId})
      : super(key: key);

  @override
  _TimeRangePickerScreenState createState() => _TimeRangePickerScreenState();
}

class _TimeRangePickerScreenState extends State<TimeRangePickerScreen> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;

  @override
  void initState() {
    super.initState();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('時間選択'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _selectStartTime(context);
              },
              child: Text('開始時間を選択'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _selectEndTime(context);
              },
              child: Text('終了時間を選択'),
            ),
            SizedBox(height: 20),
            Text('開始時間: ${_startTime.format(context)}'),
            Text('終了時間: ${_endTime.format(context)}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection('subject')
              .doc(widget.docId)
              .update({
            'startTime': _startTime.format(context),
            'endTime': _endTime.format(context),
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('勉強時間を記録しました'),
                actions: [
                  ElevatedButton(
                    child: Text('完了'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()));
                    },
                  )
                ],
              );
            },
          );
        },
        child: Text('実行'),
      ),
    );
  }
}
