import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:studytime/main.dart';

// class TimerApp extends StatelessWidget {
//   const TimerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Timer',
//       home: TimerScreen(),
//     );
//   }
// }

class TimerScreen extends StatefulWidget {
  // const TimerScreen({super.key});

  final String docId; // この行でselectedButtonを定義

  // コンストラクタでselectedButtonを受け取る
  const TimerScreen({Key? key, required this.docId}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _counttime = 0;
  late int _hours;
  late int _minutes;
  late int _seconds;
  late int _totalSeconds;
  Timer? _timer;
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;
  late TextEditingController _secondsController;

  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _hours = 0;
    _minutes = 0;
    _seconds = 0;
    _totalSeconds = 0;
    _hoursController = TextEditingController();
    _minutesController = TextEditingController();
    _secondsController = TextEditingController();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _totalSeconds = (_hours * 3600) + (_minutes * 60) + _seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_totalSeconds == 0) {
        FirebaseFirestore.instance
            .collection('user')
            .doc('time')
            .set({'time': _counttime});
        _timer?.cancel();
        setState(() {
          _isRunning = false;
          _counttime = 0;
        });
      } else {
        setState(() {
          _counttime++;
          _totalSeconds--;
          _hours = _totalSeconds ~/ 3600;
          _minutes = (_totalSeconds % 3600) ~/ 60;
          _seconds = _totalSeconds % 60;
        });
      }
    });
    setState(() {
      _isRunning = true;
    });
  }

  void stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    _timer?.cancel();
    _hoursController.clear();
    _minutesController.clear();
    _secondsController.clear();
    setState(() {
      _counttime = 0;
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
      _totalSeconds = 0;
      _isRunning = false;
    });
  }

  void complete() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タイマー'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _hoursController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        _hours = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: '時',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(':'),
                const SizedBox(width: 10),
                SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _minutesController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        _minutes = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: '分',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(':'),
                const SizedBox(width: 10),
                SizedBox(
                  width: 70,
                  child: TextField(
                    controller: _secondsController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        _seconds = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: '秒',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : startTimer,
                  child: const Text('スタート'),
                ),
                ElevatedButton(
                  onPressed: _isRunning ? stopTimer : null,
                  child: const Text('ストップ'),
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: const Text('リセット'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              '$_hours : $_minutes : $_seconds',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection('subject')
              .doc(widget.docId)
              .update({'time': _counttime.toString()});
          await resetTimer;
          await showDialog(
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
              });
        },
        child: Text('実行'),
      ),
    );
  }
}
