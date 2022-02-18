import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/db/logs_database.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/dailyLogIn_detail_page.dart';
import 'package:vhelp_test/page/notes_page_login.dart';
import 'package:vhelp_test/widget/diary_card_widget.dart';
import 'diary_detail_page.dart';
import 'edit_diary_page.dart';
import 'notes_page.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryLogInPage extends StatefulWidget {
  @override
  _DiaryLogInPageState createState() => _DiaryLogInPageState();
}

class _DiaryLogInPageState extends State<DiaryLogInPage> {
  bool isLoading = false;
  late int index = 0;

  late List<colorLog> colors;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;

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
                        backgroundColor: Colors.blue[100],
                        appBar: AppBar(
                          leading: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
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
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 22)),
                        ),
                        body: Center(
                          child: isLoading
                              ? CircularProgressIndicator()
                              : colors.isEmpty
                                  ? Text(
                                      S.of(context)!.mood_diary_message,
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 20),
                                    )
                                  : checkAno(),
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
                                    MaterialPageRoute(
                                        builder: (context) => NotesLogInPage()),
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddEditMoodPage()),
                                  );
                                  refreshNotes();
                                },
                                label: S.of(context)!.mood_diary_button2,
                                labelStyle: TextStyle(),
                                labelBackgroundColor: Colors.blueGrey[50])
                          ],
                        ));
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

  Widget checkAno() {
    if (user?.isAnonymous == false) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Accounts')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Moods')
              .orderBy('datetime', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                    child: GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DiaryLogInDetailPage(
                              colorID: document['dateID'],
                            ),
                          ));
                        },
                        child: Card(
                          color: Colors.black12,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document['dateDay'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      document['dateHour'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                IconTheme(
                                    data: IconThemeData(
                                        color: emojiColors[
                                            document['colorSaved'] as int]),
                                    child: Icon(Icons.emoji_emotions)),
                              ],
                            ),
                          ),
                        )));
              }).toList(),
            );
          });
    } else {
      return buildNotes();
    }
  }

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
