import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/notes_page_login.dart';
import '../model/note.dart';
import '../widget/note_form_widget.dart';
import 'notes_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddEditNoteLogInPage extends StatefulWidget {
  final Note? note;
  final String? noteID;

  const AddEditNoteLogInPage({
    Key? key,
    this.note,
    this.noteID,
  }) : super(key: key);
  @override
  _AddEditNoteLogInPageState createState() => _AddEditNoteLogInPageState();
}

class _AddEditNoteLogInPageState extends State<AddEditNoteLogInPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _noteDB =
      FirebaseFirestore.instance.collection('Accounts');
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
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
                                  builder: (context) => NotesLogInPage()),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        iconTheme: IconThemeData(color: Colors.black54),
                        backgroundColor: Colors.blue.shade100,
                        actions: [buildButton()],
                        elevation: 0,
                      ),
                      body: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Form(
                            key: _formKey,
                            child: NoteFormWidget(
                              isImportant: isImportant,
                              number: number,
                              title: title,
                              description: description,
                              onChangedImportant: (isImportant) => setState(
                                  () => this.isImportant = isImportant),
                              onChangedNumber: (number) =>
                                  setState(() => this.number = number),
                              onChangedTitle: (title) =>
                                  setState(() => this.title = title),
                              onChangedDescription: (description) => setState(
                                  () => this.description = description),
                            ),
                          ),
                        ),
                      ),
                    );
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

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? Colors.blueGrey : Colors.blueGrey[200],
        ),
        onPressed: addOrUpdateNote,
        child: Text(
          S.of(context)!.save,
        ),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null || widget.noteID != null;

      if (isUpdating) {
        updateNoteLI();
      } else {
        await addNoteLI();
      }

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NotesLogInPage()));
    }
  }

  Future updateNoteLI() async {
    final noteL = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    DocumentReference ref = _noteDB.doc(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference ref2 = ref.collection('Notes');

    await ref2.doc(widget.noteID).update({
      'title': noteL.title,
      'description': noteL.description,
    });

    print('test update note ///////////');
  }

  Future addNoteLI() async {
    final noteL = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );
    DocumentReference ref = _noteDB.doc(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference ref2 = ref.collection('Notes');

    final String time = DateFormat('yyyyMMddHHmmss').format(DateTime.now());
    final String timeForNote =
        DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.now());
    await ref2.doc(time).set({
      'title': noteL.title,
      'description': noteL.description,
      'datetime': timeForNote,
      'dateID': time,
    });
  }
}
