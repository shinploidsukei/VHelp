import 'package:flutter/material.dart';
import 'package:vhelp_test/db/logs_database.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/page/edit_diary_page.dart';

class DiaryDetailPage extends StatefulWidget {
  final int colorID;

  const DiaryDetailPage({Key? key, required this.colorID}) : super(key: key);

  @override
  _DiaryDetailPageState createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  late colorLog color;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.color = await LogsDatabase.instance.read(widget.colorID);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: [editButton(), deleteButton()],
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

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await LogsDatabase.instance.delete(widget.colorID);

          Navigator.of(context).pop();
        },
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditMoodPage(
            color: color,
          ),
        ));

        refreshNote();
      });
}
