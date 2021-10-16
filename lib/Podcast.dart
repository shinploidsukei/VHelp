import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';

// ignore: camel_case_types
class podcast extends StatefulWidget {
  @override
  _Podcast createState() => _Podcast();
}

class _Podcast extends State<podcast> {
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
                            SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final url =
                                    'https://www.youtube.com/channel/UC3f2SY4F9zcxY1oxt9AF9WA';
                                StandardPodcast(url: url, inApp: true);
                              },
                              child: Text('The Standard Podcast'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final url =
                                    'https://www.youtube.com/c/KNDStudio';
                                StandardPodcast(url: url, inApp: true);
                              },
                              child: Text('KND Studio'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final url =
                                    'https://www.youtube.com/c/MissiontotheMoonMedia';
                                StandardPodcast(url: url, inApp: true);
                              },
                              child: Text('Mission to the Moon'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final url =
                                    'https://www.youtube.com/c/SalmonPodcast';
                                StandardPodcast(url: url, inApp: true);
                              },
                              child: Text('Salmon Podcast'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final url =
                                    'https://www.youtube.com/channel/UC-Ta59DOm6pmkTJ_zCxjkkA';
                                StandardPodcast(url: url, inApp: true);
                              },
                              child: Text('GetTalks Pocast'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final url =
                                    'https://www.youtube.com/results?search_query=ghost+radio';
                                StandardPodcast(url: url, inApp: true);
                              },
                              child: Text('The Ghost Radio'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final url =
                                    'https://www.youtube.com/c/%E0%B9%84%E0%B8%9B%E0%B8%9B%E0%B9%8C%E0%B9%80%E0%B8%A5%E0%B9%88%E0%B8%B2%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%9C%E0%B8%B5';
                                StandardPodcast(url: url, inApp: true);
                              },
                              child: Text('ไปป์เล่าเรื่องผี'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final url =
                                    'https://www.youtube.com/channel/UCZo5ZB2p-UMqc5e1llZ1RLg';
                                StandardPodcast(url: url, inApp: true);
                              },
                              child: Text('อาจารย์ยอด'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]))))
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

  Future StandardPodcast({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false, forceWebView: true, enableJavaScript: true);
    }
  }
}
