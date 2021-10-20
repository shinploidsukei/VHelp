import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/db/TimeStamp_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/time_stamp_page.dart';

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
                  appBar: AppBar(
                    title: Text("My Time Stamp"),
                    backgroundColor: Colors.blueGrey,
                    elevation: 4.0,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      hoverColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                  ),
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
                                height: 400,
                                width: 400,
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

  // ignore: non_constant_identifier_names
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
