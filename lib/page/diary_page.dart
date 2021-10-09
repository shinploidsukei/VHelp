import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vhelp_test/Content.dart';
import '../MoodCollections.dart';
import '../db/notes_database.dart';
import '../model/note.dart';
import '../page/note_detail_page.dart';
import '../widget/note_card_widget.dart';
import 'edit_diary_page.dart';
import 'notes_page.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("My Mood Diary"),
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
        body: Container(
            child: Column(children: [
          Expanded(
            child: isLoading
                ? CircularProgressIndicator()
                : notes.isEmpty
                    ? Text(
                        'Add some stories..',
                        style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                      )
                    : buildNotes(),
          ),
        ])),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                  height: 60,
                  child: IconButton(
                      //style: ButtonStyle(backgroundColor: Colors.blueGrey),
                      //label: Text('New Page'),
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
                      //style: ButtonStyle(backgroundColor: Colors.blueGrey),
                      //label: Text('New Page'),
                      icon: Icon(Icons.table_rows, color: Colors.blueGrey),
                      onPressed: () {})),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                  height: 60,
                  child: IconButton(
                      //style: ButtonStyle(backgroundColor: Colors.blueGrey),
                      //label: Text('New Page'),
                      icon: Icon(Icons.pending_actions, color: Colors.blueGrey),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoodCollectionsPage()),
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
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
