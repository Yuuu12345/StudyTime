import 'package:flutter/material.dart';
import 'package:studytime/next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '勉強記録アプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 159, 19)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '勉強時間記録アプリ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:100.0),
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
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              )
            ),
            Padding(padding: const EdgeInsets.only(top:200.0)),
            const Text('円グラフ')
          ]
        ),
      ),
    );
  }
}
