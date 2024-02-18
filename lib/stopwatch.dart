import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:studytime/main.dart';

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch App',
      home: StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Duration _elapsedTime = Duration.zero;
  bool _isRunning = false;
  late Stopwatch _stopwatch;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  void _toggleStopwatch() {
    if (_isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _updateStopwatch();
      }
    });
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {
      _elapsedTime = Duration.zero;
      _isRunning = false;
    });
  }

  void _updateStopwatch() {
    Future.delayed(Duration(milliseconds: 30), () {
      if (_isRunning) {
        setState(() {
          _elapsedTime = _stopwatch.elapsed;
          _updateStopwatch();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _elapsedTime.toString().split('.').first;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              formattedTime,
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _toggleStopwatch,
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance.collection('user').doc('time').set({
            'time': _elapsedTime.inSeconds
          }); // assuming you want to store seconds
          _resetStopwatch(); // Reset the stopwatch after saving the time
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('勉強時間を記録しました'),
                actions: [
                  ElevatedButton(
                    child: Text('完了'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StopwatchApp()),
                      );
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
