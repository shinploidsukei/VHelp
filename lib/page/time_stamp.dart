import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';

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
                                height: 100,
                              ),
                              ElevatedButton(
                                onPressed: TakeMedicine,
                                child: Text('Take Medicine'),
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

  void TakeMedicine() {
    _launchURL() async {
      const url = 'https://vhelp.itch.io/vhelpminigame';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
