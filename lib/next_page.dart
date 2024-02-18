import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:studytime/select_timer.dart';
import 'package:studytime/stopwatch.dart';
import 'package:studytime/timer.dart';

class SelectSubject extends StatefulWidget {
  const SelectSubject({super.key});
  @override
  State<SelectSubject> createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  Future<void> addUser(String userId, Map<String, dynamic> userData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userData);
  }

  Color _parseColor(dynamic colorValue) {
    // Firestoreから取得したcolorが整数型の場合の処理
    if (colorValue is int) {
      return Color(colorValue).withOpacity(1.0); // Opacityを1.0（完全不透明）に設定
    }
    // Firestoreから取得したcolorが文字列型の場合の処理
    else if (colorValue is String && colorValue.startsWith('#')) {
      try {
        return Color(
            int.parse(colorValue.substring(1), radix: 16) + 0xFF000000);
      } catch (e) {
        // 解析に失敗した場合はデフォルトの色を返します。
        return Colors.black;
      }
    }
    // colorValueがnullまたは予期せぬ型の場合のデフォルト色
    return Colors.black;
  }

  void showColorPicker(String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('色を選択'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: nowcolor,
              onColorChanged: (Color color) async {
                await FirebaseFirestore.instance
                    .collection('subject')
                    .doc(docId)
                    .update({
                  'color': '#${color.value.toRadixString(16).padLeft(8, '0')}'
                });
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('完了'),
              onPressed: () {
                Navigator.of(context).pop();
                // ダイアログを閉じた後に何か処理を行いたい場合はここに記述
              },
            ),
          ],
        );
      },
    );
  }

  String a = '';
  final TextEditingController controller = TextEditingController();
  Color nowcolor = Colors.red;
  void sendMessage() async {
    if (controller.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('subject')
          .doc(controller.text)
          .set({
        'text': controller.text,
        'color': nowcolor.value,
        // 'timestamp': FieldValue.serverTimestamp(),
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('科目選択画面')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('subject')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('エラーが発生しました。');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('読み込み中...');
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const selectApp()));
                        },
                        title: Text(data['text']),
                        leading: ElevatedButton(
                          onPressed: () => showColorPicker(document.id),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _parseColor(data['color']),
                              minimumSize: const Size(40, 40),
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text(''),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('subject')
                                .doc(document.id)
                                .delete();
                          },
                          child: Text('➖'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: controller,
            ),
            Row(
              children: [
                ElevatedButton(
              child: const Text('ストップウォッチで測る'),
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StopwatchScreen()),
              );
              },
                ),
                ElevatedButton(
              child: const Text('タイマーで測る'),
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TimerScreen()),
              );
              }
                ),
              ]
            ),  
          ],
        ),
      ),
    );
  }
}
