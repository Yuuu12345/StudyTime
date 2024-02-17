//このdartは仮で作ったものです


import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('勉強時間記録アプリ'),
      ),
    body: Container(
      color: Colors.red,
    ),
    );
  }
}