import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhelp_test/db/TimeStamp_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';

class timeStampWidget extends StatelessWidget {
  timeStampWidget({Key? key, required this.timestamp}) : super(key: key);

  final TimeStampDetails timestamp;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMd().add_jm().format(timestamp.datetime);
    print(time);
    //final time = this.timestamp.datetime;
    return Card(
        child: Container(
      padding: EdgeInsets.all(8),
      child: Text(
        //mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        //children: [
        //Text(
        time,
        style: TextStyle(color: Colors.black),
      ),
    ));
  }
}
