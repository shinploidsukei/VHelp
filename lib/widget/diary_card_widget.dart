import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhelp_test/model/colorLog.dart';

var emojiColors = [
  Colors.red[200],
  Colors.orange[200],
  Colors.yellow[200],
  Colors.green[200],
  Colors.green[400],
];

class DiaryCardWidget extends StatelessWidget {
  DiaryCardWidget({Key? key, required this.index, required this.colorCard})
      : super(key: key);

  final colorLog colorCard;
  final int index;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(colorCard.createTime);

    return Card(
      color: Colors.black12,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 4),
            IconTheme(
                data: IconThemeData(color: emojiColors[colorCard.colorSaved]),
                child: Icon(Icons.emoji_emotions)),
          ],
        ),
      ),
    );
  }
}
