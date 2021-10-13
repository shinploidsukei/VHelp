import 'package:flutter/material.dart';
import 'package:vhelp_test/db/TimeStamp_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';

class TimestampDetailPage extends StatefulWidget {
  final String time;

  const TimestampDetailPage({Key? key, required this.time}) : super(key: key);

  @override
  _TimestampDetailPageState createState() => _TimestampDetailPageState();
}

class _TimestampDetailPageState extends State<TimestampDetailPage> {
  late TimeStampDetails time;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.time = (await TimeStampLog.instance.readAllLog()) as TimeStampDetails;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        // actions: [editButton(), deleteButton()],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(12),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: [
                  SizedBox(height: 4),
                  Icon(Icons.emoji_emotions),
                ],
              ),
            ),
    );
  }
}
