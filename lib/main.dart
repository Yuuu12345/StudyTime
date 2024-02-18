import 'package:flutter/material.dart';
import 'package:studytime/next_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 159, 19)),
        useMaterial3: true,
      ),
      home: piechartSample(),
    );
  }
}

class piechartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = List.generate(6, (index) {
      final double radius = 50;
      switch (index) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 40,
            title: 'sample1',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: 8,fontWeight: FontWeight.bold,color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: 20,
            title: 'sample2',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: 8,fontWeight: FontWeight.bold,color: Colors.white),
          );
        case 2:
         return PieChartSectionData(
          color: Colors.green,
          value: 15,
          title: 'sample3',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: 8,fontWeight: FontWeight.bold,color: Colors.white),
         );
        case 3:
         return PieChartSectionData(
          color: Colors.orange,
          value: 10,
          title: 'sample4',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: 8,fontWeight: FontWeight.bold,color: Colors.white),
         );
        case 4:
         return PieChartSectionData(
          color: Colors.purple,
          value: 100-90,
          title: 'sample5',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: 8,fontWeight: FontWeight.bold,color: Colors.white),
         );
        case 5:
         return PieChartSectionData(
          color: Colors.yellow,
          value: 5,
          title: 'sample6',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: 8,fontWeight: FontWeight.bold,color: Colors.white)
         );
        default:
         return null!;
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('勉強時間記録アプリ'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                child: const Text('記録する'),                
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectSubject()),
                );
              },
              )
            ),
            const Text('円グラフ'),
            SizedBox(
              width:200,
              height:300,
              
              child:PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius:20,
                  sections: sections,
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}