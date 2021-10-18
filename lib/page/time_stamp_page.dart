import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/db/logs_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';
import 'package:vhelp_test/widget/timestamp_card_widget.dart';

class TimestampPage extends StatefulWidget {
  @override
  _TimestampPageState createState() => _TimestampPageState();
}

class _TimestampPageState extends State<TimestampPage> {
  bool isLoading = false;
  //late int index = 0;

  //ตรงนี้แหละ
  TimeStampDetails time = new TimeStampDetails(datetime: DateTime.now());

  @override
  void initState() {
    super.initState();
    //this.time = await TimeStampLog.instance.readAllLog();
    // refreshNotes();
  }

  @override
  void dispose() {
    LogsDatabase.instance.close();
    super.dispose();
  }

  /* Future refreshNotes() async {
    this.time = await TimeStampLog.instance.readAllLog();
    //this.time = await TimeStampDetails.instance.readAllLog();
  }*/

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("My Timestamp Log"),
          backgroundColor: Colors.blueGrey,
          elevation: 4.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            hoverColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
        body: Center(
            child: Column(children: [
          Expanded(
            child: buildNotes(),
          ),
        ])),
      );

  Widget buildNotes() {
    return timeStampWidget(timestamp: time); //timeStampWidget(timestamp: time),
  }
}
