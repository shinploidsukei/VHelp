import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/diary_page.dart';
import 'package:vhelp_test/page/edit_diary_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryLogInDetailPage extends StatefulWidget {
  final String colorID;

  const DiaryLogInDetailPage({Key? key, required this.colorID})
      : super(key: key);

  @override
  _DiaryLogINDetailPageState createState() => _DiaryLogINDetailPageState();
}

class _DiaryLogINDetailPageState extends State<DiaryLogInDetailPage> {
  late colorLog color;
  bool isLoading = false;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _moodDB =
      FirebaseFirestore.instance.collection('Accounts');
  User? user = FirebaseAuth.instance.currentUser;

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

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, model, snapshot) {
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
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiaryPage()),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        iconTheme: IconThemeData(color: Colors.black54),
                        backgroundColor: Colors.blue.shade100,
                        actions: [editButton(), deleteButton()],
                        elevation: 0,
                        title: Text(S.of(context)!.moodTopic,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 22)),
                      ),
                      body: Center(
                          child: isLoading
                              ? Center(child: CircularProgressIndicator())
                              : toBody()),
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

  Widget toBody() {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Accounts')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Moods')
            .doc(widget.colorID)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: IconTheme(
                data: IconThemeData(
                    color: emojiColors[data['colorSaved'] as int], size: 100),
                child: Icon(Icons.emoji_emotions)),
          );
        });
  }

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Do you want to delete your mood?"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Back')),
                    TextButton(
                        onPressed: () async {
                          DocumentReference ref = _moodDB
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('Moods')
                              .doc(widget.colorID);
                          await ref.delete();

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DiaryPage()));
                        },
                        child: Text('Delete!'))
                  ],
                );
              });
        },
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditMoodPage(
            colorID: widget.colorID,
          ),
        ));
        refreshNote();
      });
}
