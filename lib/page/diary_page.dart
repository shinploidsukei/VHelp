import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/db/logs_database.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/widget/diary_card_widget.dart';
import 'diary_detail_page.dart';
import 'edit_diary_page.dart';
import 'notes_page.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  bool isLoading = false;
  late int index = 0;

  late List<colorLog> colors;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    LogsDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.colors = await LogsDatabase.instance.readAll();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
        actions: [
          LanguagePickerWidget(),
          //const SizedBox(width: 12),
        ],
        title: Text(S.of(context)!.mood_diary,
            style: TextStyle(color: Colors.black54, fontSize: 22)),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : colors.isEmpty
                ? Text(
                    S.of(context)!.mood_diary_message,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                  )
                : buildNotes(),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        backgroundColor: Colors.blue[200],
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              child: Icon(Icons.create),
              backgroundColor: Colors.blueGrey,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesPage()),
                );
              },
              label: S.of(context)!.mood_diary_button1,
              labelStyle: TextStyle(),
              labelBackgroundColor: Colors.blueGrey[50]),
          SpeedDialChild(
              child: Icon(Icons.emoji_emotions),
              backgroundColor: Colors.blueGrey,
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddEditMoodPage()),
                );
                refreshNotes();
              },
              label: S.of(context)!.mood_diary_button2,
              labelStyle: TextStyle(),
              labelBackgroundColor: Colors.blueGrey[50])
        ],
      ));

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: colors.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final sortedItems = colors.reversed.toList();
          final color = sortedItems[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DiaryDetailPage(
                  colorID: color.id!,
                ),
              ));

              refreshNotes();
            },
            child: DiaryCardWidget(colorCard: color, index: index),
          );
        },
      );
}
