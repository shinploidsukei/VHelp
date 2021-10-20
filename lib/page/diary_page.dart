import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/db/logs_database.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/widget/diary_card_widget.dart';
import 'diary_detail_page.dart';
import 'edit_diary_page.dart';
import 'notes_page.dart';

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
          title: Text('My Mood Diary',
              style: TextStyle(color: Colors.black54, fontSize: 22)),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : colors.isEmpty
                  ? Text(
                      'Add some mood..',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    )
                  : buildNotes(),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                  height: 60,
                  child: IconButton(
                      icon: Icon(Icons.create, color: Colors.blueGrey),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotesPage()),
                        );
                      })),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                  height: 60,
                  child: IconButton(
                      icon: Icon(Icons.table_rows, color: Colors.blueGrey),
                      onPressed: () {})),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                  height: 60,
                  child: IconButton(
                      icon: Icon(Icons.pending_actions, color: Colors.blueGrey),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      })),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditMoodPage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: colors.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final color = colors[index];

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
