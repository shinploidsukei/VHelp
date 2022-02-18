import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/db/TimeStamp_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/time_stamp.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimestampLogInPage extends StatefulWidget {
  @override
  _TimestampLogInPageState createState() => _TimestampLogInPageState();
}

//var dbHelper = TimeStampLog;

class _TimestampLogInPageState extends State<TimestampLogInPage> {
  final int capacityLog = 0;
  int getcountnum = 0;
  bool isLoading = false;
  late List<TimeStampDetails> times;
  int countID1 = 7;
  int countID2 = 0;

  //late TimeStampDetails getCount;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;

  void countID() async {
    int? count = await TimeStampLog.instance.countID();
    setState(() => countID1 = count!);
    print("CountID:" + '$countID1');
  }

  @override
  void initState() {
    print('Before: $countID1');
    super.initState();
    countID();
    getcount();
    print(countID1);
    print(countID2);
    //checkEvent();
    refreshNotes();
  }

  getcount() async {
    print("TestCollecRef");
    //var itemscount = List<dynamic>();
    QuerySnapshot<Map<String, dynamic>> _timeDB = await FirebaseFirestore
        .instance
        .collection('Accounts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('TimeStamp')
        .get();

    print('setstatecheck');
    print(_timeDB.size);
    var countnum = _timeDB.size;
    setState(() => countID2 = countnum);
    print("CountNum:" + '$countID2');
  }

  @override
  void dispose() {
    //TimeStampLog.instance.close();
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
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 22)),
                          actions: [
                            LanguagePickerWidget(),
                            //const SizedBox(width: 12),
                          ],
                        ),
                        body: Center(
                            child: isLoading
                                ? CircularProgressIndicator()
                                : StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Accounts')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection('TimeStamp')
                                        .orderBy('datetime', descending: true)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      print('you log in idiot!');
                                      return ListView(
                                        children:
                                            snapshot.data!.docs.map((document) {
                                          return Container(
                                            child: Center(
                                                child: Card(
                                                    color: Colors.black12,
                                                    child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 120,
                                                                right: 120,
                                                                top: 5,
                                                                bottom: 5),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              document[
                                                                  'datetime'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        )))),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  )),
                        bottomNavigationBar: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (user?.isAnonymous == true)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                      S.of(context)!.total_logs + ' $countID1'),
                                )
                              else
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                      S.of(context)!.total_logs + '$countID2'),
                                )
                            ]));
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
}
