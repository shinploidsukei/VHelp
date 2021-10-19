import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';

final _lightColors = [
  Colors.blueGrey[100],
];

// ignore: camel_case_types
class timeStampWidget extends StatelessWidget {
  timeStampWidget({Key? key, required this.timestamp}) : super(key: key);

  final TimeStampDetails timestamp;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[0];
    final time = DateFormat('yyyy-MM-dd – kk:mm').format(timestamp.datetime);

    return Card(
        color: color,
        child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            )));
  }
}
