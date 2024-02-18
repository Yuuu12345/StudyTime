import 'package:flutter/material.dart';
import 'package:studytime/stopwatch.dart';
import 'package:studytime/timer.dart';
import 'package:studytime/next_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  runApp(TimerApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 6, 159, 19)),
        useMaterial3: true,
      ),
      home: const piechartSample(),
    );
  }
}

class piechartSample extends StatelessWidget {
  const piechartSample({super.key});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = List.generate(6, (index) {
      const double radius = 50;
      switch (index) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: 'sample1',
            radius: radius,
            titleStyle: const TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: 20,
            title: 'sample2',
            radius: radius,
            titleStyle: const TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: 'sample3',
            radius: radius,
            titleStyle: const TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: 10,
            title: 'sample4',
            radius: radius,
            titleStyle: const TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.purple,
            value: 10,
            title: 'sample5',
            radius: radius,
            titleStyle: const TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 5:
          return PieChartSectionData(
              color: Colors.yellow,
              value: 5,
              title: 'sample6',
              radius: radius,
              titleStyle: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.white));
        default:
          return null!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                child: const Text('記録する'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SelectSubject()),
                  );
                },
              )),
          const Text('円グラフ'),
          SizedBox(
            width: 200,
            height: 150,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 20,
                sections: sections,
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
