import 'package:flutter/material.dart';
import 'dart:async';

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int _hours;
  late int _minutes;
  late int _seconds;
  late int _totalSeconds;
  late Timer _timer;
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
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _totalSeconds = (_hours * 3600) + (_minutes * 60) + _seconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_totalSeconds == 0) {
        _timer.cancel();
        setState(() {
          _isRunning = false;
        });
      } else {
        setState(() {
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
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    _timer.cancel();
    _hoursController.clear();
    _minutesController.clear();
    _secondsController.clear();
    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
      _totalSeconds = 0;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
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
                    decoration: InputDecoration(
                      labelText: 'Hours',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(':'),
                SizedBox(width: 10),
                Container(
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
                    decoration: InputDecoration(
                      labelText: 'Minutes',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(':'),
                SizedBox(width: 10),
                Container(
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
                    decoration: InputDecoration(
                      labelText: 'Seconds',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? null : startTimer,
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: _isRunning ? stopTimer : null,
                  child: Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '$_hours : $_minutes : $_seconds',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
