import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/db/TimeStamp_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/time_stamp_page.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: camel_case_types
class timeStamp extends StatefulWidget {
  @override
  _timeStampState createState() => _timeStampState();
}

// ignore: camel_case_types
class _timeStampState extends State<timeStamp> {
  late bool isEnterTrue;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? Scaffold(
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
                    actions: [
                      LanguagePickerWidget(),
                      //const SizedBox(width: 12),
                    ],
                    title: Text(
                        S.of(context)!.sidebar1_topic,
                        style: TextStyle(color: Colors.black54, fontSize: 22)),
                  ),
                  body: Container(
                      child: Center(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/map.png',
                            height: 400,
                            width: 400,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text(S.of(context)!.warning,),
                                content: Text(
                                  S.of(context)!.warning_message,),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, S.of(context)!.cancel,),
                                    child: Text(S.of(context)!.cancel,),
                                  ),
                                  TextButton(
                                    child: Text(S.of(context)!.ok,),
                                    onPressed: TakeMedicine,
                                  ),
                                ],
                              ),
                            ),
                            child: Text(
                              S.of(context)!.timestamp_button1,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => TimestampPage()));*/
                              countID();
                              //checkEvent();
                              // CheckCount();
                            },
                            child: Text(
                                S.of(context)!.timestamp_button2,
                            ),
                          ),
                          /*ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.email),
                                label: Text("Timestamp Log"),
                                style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(fontSize: 15),
                                ),
                              ),*/
                        ]),
                  )))
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

    final timetakemed = TimeStampDetails(
      datetime: DateTime.now(),
    );

    await TimeStampLog.instance.create(timetakemed);
  }

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
          title: Text(S.of(context)!.mission1,),
          content: Text(S.of(context)!.mission_message1,),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, S.of(context)!.cancel,),
              child: Text(S.of(context)!.cancel,),
            ),
            TextButton(
                child: Text(S.of(context)!.done,),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TimestampPage(),
                    ))),
          ],
        ),
      );
    } else if (countID1 == 14) {
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(S.of(context)!.mission1,),
          content: Text(S.of(context)!.mission_message2,),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, S.of(context)!.cancel,),
              child: Text(S.of(context)!.cancel,),
            ),
            TextButton(
                child: Text(S.of(context)!.done,),
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
          title: Text(S.of(context)!.mission1,),
          content: Text(S.of(context)!.mission_message3,),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, S.of(context)!.cancel,),
              child: Text(S.of(context)!.cancel,),
            ),
            TextButton(
                child: Text(S.of(context)!.done,),
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
          title: Text(S.of(context)!.mission1,),
          content: Text(S.of(context)!.mission_message4,),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, S.of(context)!.cancel,),
              child: Text(S.of(context)!.cancel,),
            ),
            TextButton(
                child: Text(S.of(context)!.done,),
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
          title: Text(S.of(context)!.goodjobs,),
          content: Text(S.of(context)!.mission_message5,),
          actions: <Widget>[
            TextButton(
                child: Text(S.of(context)!.ok,),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TimestampPage(),
                    ))),
          ],
        ),
      );
    }
  }
}
