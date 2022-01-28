import 'package:flutter/material.dart';
import 'package:vhelp_test/db/logs_database.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/page/diary_page.dart';
import 'package:vhelp_test/page/edit_diary_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryDetailPage extends StatefulWidget {
  final int colorID;

  const DiaryDetailPage({Key? key, required this.colorID}) : super(key: key);

  @override
  _DiaryDetailPageState createState() => _DiaryDetailPageState();
}

class _DiaryDetailPageState extends State<DiaryDetailPage> {
  late colorLog color;
  bool isLoading = false;

  var emojiColors = [
    Colors.red[200],
    Colors.orange[200],
    Colors.yellow[200],
    Colors.green[200],
    Colors.green[400],
  ];

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiaryPage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.blue.shade100,
        actions: [editButton(), deleteButton()],
        elevation: 0,
        title: Text(S.of(context)!.moodTopic,
            style: TextStyle(color: Colors.black54, fontSize: 22)),
      ),
      body: Center(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: IconTheme(
                    data: IconThemeData(
                        color: emojiColors[color.colorSaved], size: 100),
                    child: Icon(Icons.emoji_emotions)),
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
