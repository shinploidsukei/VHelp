import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:url_launcher/url_launcher.dart';
import '/TimeStampLog.dart';

class timestamp extends StatefulWidget {
  @override
  _Timestamp createState() => _Timestamp();
}

class _Timestamp extends State<timestamp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    _launchURL() async {
      const url = 'https://vhelp.itch.io/vhelpminigame';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline != null) {
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
                                child: Text('Take Medicine'),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(300, 50),
                                  primary: Colors.blue[700],
                                  onPrimary: Colors.white,
                                ),
                                onPressed: _launchURL,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                child: Text('Your Timestamp'),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(300, 50),
                                  primary: Colors.blue[700],
                                  onPrimary: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TimeStampLog()),
                                  );
                                },
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
}
