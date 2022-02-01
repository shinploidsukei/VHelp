import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/db/TimeStamp_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/time_stamp.dart';
import 'package:vhelp_test/widget/timestamp_card_widget.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimestampPage extends StatefulWidget {
  @override
  _TimestampPageState createState() => _TimestampPageState();
}

//var dbHelper = TimeStampLog;

class _TimestampPageState extends State<TimestampPage> {
  bool isLoading = false;
  late List<TimeStampDetails> times;
  int countID1 = 7;
  //late TimeStampDetails getCount;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference _timeDB =
      FirebaseFirestore.instance.collection('Accounts');

  void countID() async {
    int? count = await TimeStampLog.instance.countID();
    setState(() => countID1 = count!);
  }

  @override
  void initState() {
    print('Before: $countID1');
    super.initState();
    countID();
    print(countID1);
    //checkEvent();
    refreshNotes();
  }

  @override
  void dispose() {
    //TimeStampLog.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.times = await TimeStampLog.instance.readAllLog();

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
                                  builder: (context) => timeStamp()),
                            );
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        iconTheme: IconThemeData(color: Colors.black54),
                        backgroundColor: Colors.blue.shade100,
                        elevation: 0,
                        title: Text(S.of(context)!.timestamp_log_topic,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 22)),
                        actions: [
                          LanguagePickerWidget(),
                          //const SizedBox(width: 12),
                        ],
                      ),
                      body: Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : times.isEmpty
                                ? Text(
                                    S.of(context)!.timestamp_log_message,
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 20),
                                  )
                                : checkAno(),
                      ),
                      bottomNavigationBar: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                  S.of(context)!.total_logs + ' $countID1'),
                            )
                          ]),
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

  Widget checkAno() {
    DocumentReference ref = _timeDB.doc(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference ref2 = ref.collection('TimeStamp');
    if (user?.isAnonymous == false) {
      print('hihi');
      return buildNotesLog();
    } else {
      print('hellohello');
      return buildNotesAno();
    }
  }

  Widget buildNotesAno() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: times.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(4),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final time = times[index];
          return timeStampWidget(timestamp: time);
        },
      );

       Widget buildNotesLog() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: times.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(4),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final time = times[index];
          return timeStampWidget(timestamp: time);
        },
      );
}
