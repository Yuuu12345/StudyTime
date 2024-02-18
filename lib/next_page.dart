import 'dart:html';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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

  void showColorPicker(String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('色を選択'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: nowcolor,
              onColorChanged: (Color color) {
                setState(() {
                  FirebaseFirestore.instance
                      .collection('subject')
                      .doc(docId)
                      .update({
                    'color': '#${color.value.toRadixString(16).padLeft(8, '0')}'
                  });
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
      await FirebaseFirestore.instance.collection('subject').add({
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
                      // 正しく return を使ってウィジェットを返す
                      return ListTile(
                          title: Text(data['text'] ?? 'テキストがありません'),
                          subtitle: Text('カラーID: ${data['color'].toString()}'),
                          leading: ElevatedButton(
                            onPressed: () => showColorPicker(document.id),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: (data['color'] != null)
                                    ? Color(int.parse(
                                            data['color'].substring(1, 7),
                                            radix: 16) +
                                        0xFF000000)
                                    : Colors.black,
                                minimumSize: Size(40, 40),
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: Text(''),
                          ));
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: controller,
            ),
            ElevatedButton(
              onPressed: sendMessage,
              child: const Text('送信'),
            ),
          ],
        ),
      ),
    );
  }
}
