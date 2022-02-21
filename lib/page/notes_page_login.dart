import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/diary_login_page.dart';
import 'package:vhelp_test/page/edit_note_login_page.dart';
import 'package:vhelp_test/page/noteLogIn_detail_page.dart';
import '../db/notes_database.dart';
import '../model/note.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotesLogInPage extends StatefulWidget {
  @override
  _NotesLogInPageState createState() => _NotesLogInPageState();
}

class _NotesLogInPageState extends State<NotesLogInPage> {
  late List<Note> notes;
  bool isLoading = false;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;

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
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline) {
        return model.isOnline
            ? FutureBuilder(
                future: firebase,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('Error'),
                      ),
                      body: Center(
                        child: Text('${snapshot.error}'),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Scaffold(
                      backgroundColor: Colors.blue.shade100,
                      appBar: AppBar(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiaryLogInPage()),
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
                        title: Text(S.of(context)!.diary,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 22)),
                      ),
                      body: Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('Accounts')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('Notes')
                                    .orderBy('datetime', descending: true)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return ListView(
                                    children:
                                        snapshot.data!.docs.map((document) {
                                      return Container(
                                          child: GestureDetector(
                                        onTap: () async {
                                          await Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                NoteLogInDetailPage(
                                              noteId: document['dateID'],
                                            ),
                                          ));
                                        },
                                        child: Card(
                                          color: Colors.black12,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  document['datetime'],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  document['title'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                    }).toList(),
                                  );
                                }),
                      ),
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: Colors.blueGrey,
                        child: Icon(Icons.add),
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AddEditNoteLogInPage()),
                          );

                          refreshNotes();
                        },
                      ),
                    );
                  }

                  return Container(
                    child: Center(child: NoInternet()),
                  );
                })
            : NoInternet();
      }
      return Container(
        child: Center(
          child: NoInternet(),
        ),
      );
    });
  }
}
