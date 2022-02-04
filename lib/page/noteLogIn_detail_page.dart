import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/edit_note_page.dart';
import 'package:vhelp_test/page/notes_page.dart';

class NoteLogInDetailPage extends StatefulWidget {
  final String noteId;

  const NoteLogInDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteLogInDetailPageState createState() => _NoteLogInDetailPageState();
}

class _NoteLogInDetailPageState extends State<NoteLogInDetailPage> {
  bool isLoading = false;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _noteDB =
      FirebaseFirestore.instance.collection('Accounts');
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
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
                                    builder: (context) => NotesPage()),
                              );
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          iconTheme: IconThemeData(color: Colors.black54),
                          backgroundColor: Colors.blue.shade100,
                          actions: [editButton(), deleteButton()],
                          elevation: 0,
                        ),
                        body: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : toBody());
                  }
                  return Container(
                    child: Center(
                      child: NoInternet(),
                    ),
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

  Widget toBody() {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Accounts')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Notes')
            .doc(widget.noteId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: EdgeInsets.all(12),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8),
              children: [
                new Text(
                  '${data['title']}',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${data['datetime']}',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                SizedBox(height: 8),
                Text(
                  '${data['description']}',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                )
              ],
            ),
          );
        });
  }

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(
            noteID: widget.noteId,
          ),
        ));
      });

  Widget deleteButton() => IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Do you want to delete your page?"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Back')),
                  TextButton(
                      onPressed: () async {
                        DocumentReference ref = _noteDB
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('Notes')
                            .doc(widget.noteId);
                        await ref.delete();

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NotesPage()));
                      },
                      child: Text('Delete!'))
                ],
              );
            });
      });
}
