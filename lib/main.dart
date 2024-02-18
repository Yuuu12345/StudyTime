import 'dart:ffi';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 159, 19)),
        useMaterial3: true,
      ),
      home: piechartSample(),
    );
  }
}


class piechartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //  Future<void> get() async {
  //CollectionReference collection = FirebaseFirestore.instance.collection('subject');
  //QuerySnapshot querySnapshot = await collection.get();
  //int documentCount = querySnapshot.size;
    //for(int num = 1; num < documentCount; num++){
      //String n = num.toString();
      //double remainder = 0;
        //Future<void> get() async {
    //CollectionReference subject = FirebaseFirestore.instance.collection('subject');
    //CollectionReference times = FirebaseFirestore.instance.collection('times');
    //final doc = await subject.doc(n).get();
    //final docment = await times.doc(n).get();
    //final timer = doc.get('times');
    //final subjectname = doc.get('text');
    //final colorname = doc.get('color'); 
    //final now_times = docment.get('times');
    //double nt = double.parse(now_times);


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
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: 20,
            title: 'sample2',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: 'sample3',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: 10,
            title: 'sample4',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.purple,
            value: 10,
            title: 'sample5',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
          );
        case 5:
          return PieChartSectionData(
              color: Colors.yellow,
              value: 5,
              title: 'sample6',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Colors.white));
        default:
          return null!;
      }
    });
    //}
    //}
    //}
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('勉強時間記録アプリ'),
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
                    MaterialPageRoute(builder: (context) => SelectSubject()),
                  );
                },
              )),
          const Text('円グラフ'),
          SizedBox(
            width: 200,
            height: 300,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 15,
                sections: sections,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
