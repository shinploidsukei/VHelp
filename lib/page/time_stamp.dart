import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/db/TimeStamp_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/time_stamp_page.dart';
import 'package:vhelp_test/widget/timestamp_card_widget.dart';

class timeStamp extends StatefulWidget {
  @override
  _timeStampState createState() => _timeStampState();
}

class _timeStampState extends State<timeStamp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    late List<TimeStampLog> time1;

    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? Scaffold(
                  body: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue.shade200, Colors.blueGrey],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/map.png',
                                height: 450,
                                width: 450,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Warning!'),
                                    content: const Text(
                                        'Please take the medicines by following the prescription seriously. Overdose means lethal action!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () async {
                                          final url =
                                              'https://vhelp.itch.io/vhelpminigame';
                                          TakeMedicine(url: url, inApp: true);
                                         // addtoLog();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                child: Text('Take Medicine'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => TimestampPage()));
                                },
                                child: Text('Timestamp Log'),
                              )
                            ]),
                      )))
              : NoInternet();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

 /* Future addtoLog() async {
    final log = TimeStampDetails(
      datetime: DateTime.now(),
    );

    await TimeStampLog.instance.create(log);
    print(log.toString());
  }
*/
  Future TakeMedicine({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false, forceWebView: true, enableJavaScript: true);
    }

    final timetakemed = TimeStampDetails(
      datetime: DateTime.now(),
    );

    await TimeStampLog.instance.create(timetakemed);
  }
}
