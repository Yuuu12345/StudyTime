import 'package:flutter/material.dart';

// class StopwatchApp extends StatelessWidget {
//   const StopwatchApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Stopwatch App',
//       home: StopwatchScreen(),
//     );
//   }
// }

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

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
    Future.delayed(const Duration(milliseconds: 30), () {
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
        title: const Text('ストップウォッチ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              formattedTime,
              style: const TextStyle(fontSize: 48.0),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _toggleStopwatch,
                  child: Text(_isRunning ? 'ストップ' : 'スタート'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: const Text('リセット'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
