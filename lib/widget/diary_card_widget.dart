import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhelp_test/model/colorLog.dart';

final _lightColors = [
  Colors.blueGrey[100],
  Colors.blueGrey[100],
  Colors.blueGrey[100],
  Colors.blueGrey[100],
  Colors.blueGrey[100],
  Colors.blueGrey[100]
];

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
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(colorCard.createTime);

    return Card(
      color: color,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
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
