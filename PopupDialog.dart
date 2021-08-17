import 'package:flutter/material.dart';

// This class is _selectPopup(context)
class PopupDialog extends StatefulWidget {
  const PopupDialog({
    Key? key,
    required this.selectedIndex,
    required this.emojiColor,
  }) : super(key: key);

  final int selectedIndex;
  final Color emojiColor;

  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
  var titles = [
    '💓 Tomorrow will be better 💓',
    'Stay strong ❤️',
    'Keep it up ✌🏻✌🏻',
    '✨ Good Job ✨',
    'Congratulations 🎉'
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titles[widget.selectedIndex]),
      titlePadding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.emoji_emotions, color: widget.emojiColor, size: 50)
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue.shade100, // background
            onPrimary: Colors.black, // foreground
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
