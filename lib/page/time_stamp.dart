import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/db/TimeStamp_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/time_stamp_login_page.dart';
import 'package:vhelp_test/page/time_stamp_page.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flexible/flexible.dart';

// ignore: camel_case_types
class timeStamp extends StatefulWidget {
  @override
  _timeStampState createState() => _timeStampState();
}

// ignore: camel_case_types
class _timeStampState extends State<timeStamp> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _timeDB =
      FirebaseFirestore.instance.collection('Accounts');
  User? user = FirebaseAuth.instance.currentUser;
  late bool isEnterTrue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? ScreenFlexibleWidget(
                  child: Builder(
                    builder: (BuildContext context) {
                      return FutureBuilder(
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
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
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
                                  iconTheme:
                                      IconThemeData(color: Colors.black54),
                                  backgroundColor: Colors.blue.shade100,
                                  elevation: 0,
                                  actions: [
                                    LanguagePickerWidget(),
                                    //const SizedBox(width: 12),
                                  ],
                                  title: Text(S.of(context)!.sidebar1_topic,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: flexible(context, 22.0))),
                                ),
                                body: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage("assets/images/map.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: flexible(context, 50.0),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.black
                                                      .withOpacity(flexible(
                                                          context, 0.05)),
                                                  textStyle:
                                                      TextStyle(
                                                          fontSize: flexible(
                                                              context, 20.0),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  fixedSize: Size(
                                                      flexible(context, 200.0),
                                                      flexible(context, 50.0))),
                                              onPressed: () =>
                                                  showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: Text(
                                                    S.of(context)!.warning,
                                                  ),
                                                  content: Text(
                                                    S
                                                        .of(context)!
                                                        .warning_message,
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                        context,
                                                        S.of(context)!.cancel,
                                                      ),
                                                      child: Text(
                                                        S.of(context)!.cancel,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      child: Text(
                                                        S.of(context)!.ok,
                                                      ),
                                                      onPressed: TakeMedicine,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              child: Text(
                                                S
                                                    .of(context)!
                                                    .timestamp_button1,
                                              ),
                                            ),
                                            SizedBox(
                                              height: flexible(context, 20.0),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.black
                                                      .withOpacity(flexible(
                                                          context, 0.05)),
                                                  //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                                  textStyle:
                                                      TextStyle(
                                                          fontSize: flexible(
                                                              context, 20.0),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  fixedSize: Size(
                                                      flexible(context, 200.0),
                                                      flexible(context, 50.0))),
                                              onPressed: () {
                                                countID();
                                              },
                                              child: Text(
                                                S
                                                    .of(context)!
                                                    .timestamp_button2,
                                              ),
                                            ),
                                          ]),
                                    )));
                          }
                          return Container(
                            child: Center(
                              child: NoInternet(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              : NoInternet();
        }
        return Container(
          child: Center(
            child: NoInternet(),
          ),
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  TakeMedicine() async {
    const url = 'https://vhelp.itch.io/vhelpminigame';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

    print('Test Time Stamp');

    if (user?.isAnonymous == false) {
      final String time =
          DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.now());
      DocumentReference ref =
          _timeDB.doc(FirebaseAuth.instance.currentUser!.uid);
      CollectionReference ref2 = ref.collection('TimeStamp');
      await ref2.add({'datetime': time});
      print('hi');
    } else {
      final timetakemed = TimeStampDetails(
        datetime: DateTime.now(),
      );
      await TimeStampLog.instance.create(timetakemed);
      print('hello');
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomePage(),
    ));
  }

  // ignore: non_constant_identifier_names

  var countID1;
  Future<String?> countID() async {
    int? count = await TimeStampLog.instance.countID();
    setState(() => countID1 = count!);

    countID1 = count;
    print("Check Count: $count");
    if (countID1 == 7) {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            S.of(context)!.mission1,
          ),
          content: Text(
            S.of(context)!.mission_message1,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                S.of(context)!.cancel,
              ),
              child: Text(
                S.of(context)!.cancel,
              ),
            ),
            TextButton(
                child: Text(
                  S.of(context)!.done,
                ),
                onPressed: () {
                  print('wrong navigator');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TimestampPage(),
                  ));
                }),
          ],
        ),
      );
    } else if (countID1 == 14) {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            S.of(context)!.mission1,
          ),
          content: Text(
            S.of(context)!.mission_message2,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                S.of(context)!.cancel,
              ),
              child: Text(
                S.of(context)!.cancel,
              ),
            ),
            TextButton(
                child: Text(
                  S.of(context)!.done,
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TimestampPage(),
                    ))),
          ],
        ),
      );
    } else if (countID1 == 21) {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            S.of(context)!.mission1,
          ),
          content: Text(
            S.of(context)!.mission_message3,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                S.of(context)!.cancel,
              ),
              child: Text(
                S.of(context)!.cancel,
              ),
            ),
            TextButton(
                child: Text(
                  S.of(context)!.done,
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TimestampPage(),
                    ))),
          ],
        ),
      );
    } else if (countID1 == 30) {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            S.of(context)!.mission1,
          ),
          content: Text(
            S.of(context)!.mission_message4,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(
                context,
                S.of(context)!.cancel,
              ),
              child: Text(
                S.of(context)!.cancel,
              ),
            ),
            TextButton(
                child: Text(
                  S.of(context)!.done,
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TimestampPage(),
                    ))),
          ],
        ),
      );
    } else {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            S.of(context)!.goodjobs,
          ),
          content: Text(
            S.of(context)!.mission_message5,
          ),
          actions: <Widget>[
            TextButton(
                child: Text(
                  S.of(context)!.ok,
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TimestampPage(),
                    ))),
          ],
        ),
      );
    }
  }
}
