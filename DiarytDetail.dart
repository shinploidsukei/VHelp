import 'package:flutter/material.dart';
import 'PopupDialog.dart';

// This class is myDetailsContainer()
class DiaryDetail extends StatefulWidget {
  const DiaryDetail({
    Key? key,
    required this.day,
  }) : super(key: key);

  final int day;

  @override
  _DiaryDetailState createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  int? selectedIndex;

  var emojiColors = [
    Colors.red[200],
    Colors.orange[200],
    Colors.yellow[200],
    Colors.green[200],
    Colors.green[400],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          //padding: const EdgeInsets.only(left: 1.0),
          child: Container(
              child: Text(
            "Day ${widget.day + 1}",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        SizedBox(height: 10),
        Container(
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ...List.generate(5, (index) => _buildEmoji(index)),
            ],
          )),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildEmoji(int index) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.emoji_emotions),
        color: selectedIndex == index ? Colors.black : emojiColors[index],
        iconSize: 40.0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => PopupDialog(
              selectedIndex: index,
              emojiColor: emojiColors[index]!,
            ),
          );
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
