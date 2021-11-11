import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PodcastPage extends StatefulWidget {
  @override
  PodcastPageState createState() => PodcastPageState();
}

class PodcastPageState extends State<PodcastPage> {
  standPod() async {
    const url = 'https://www.youtube.com/channel/UC3f2SY4F9zcxY1oxt9AF9WA';
    if (!await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  knd() async {
    const url = 'https://www.youtube.com/c/KNDStudio';
    if (!await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  toTheMoon() async {
    const url = 'https://www.youtube.com/c/MissiontotheMoonMedia';
    if (!await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  salmon() async {
    const url = 'https://www.youtube.com/c/SalmonPodcast';
    if (!await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getTalks() async {
    const url = 'https://www.youtube.com/channel/UC-Ta59DOm6pmkTJ_zCxjkkA';
    if (!await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ghost() async {
    const url = 'https://www.youtube.com/results?search_query=ghost+radio';
    if (!await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  pipe() async {
    const url =
        'https://www.youtube.com/c/%E0%B9%84%E0%B8%9B%E0%B8%9B%E0%B9%8C%E0%B9%80%E0%B8%A5%E0%B9%88%E0%B8%B2%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%9C%E0%B8%B5';
    if (!await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ajarn() async {
    const url = 'https://www.youtube.com/channel/UCZo5ZB2p-UMqc5e1llZ1RLg';
    if (!await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: buildPages(),
      );

  Widget buildPages() {
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
                        S.of(context)!.sidebar8,
                        style: TextStyle(color: Colors.black54, fontSize: 22)),
                  ),
                  body: Container(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: GridView.count(
                        crossAxisCount: 1,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: [
                          new GestureDetector(
                            onTap: () {
                              standPod();
                            },
                            child: Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.65,
                                      child: Image.asset(
                                        'assets/images/standpod.jpeg',
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "The Standard Podcast",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              knd();
                            },
                            child: new Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    new Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.65,
                                      child: new Image.asset(
                                        'assets/images/knd.png',
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "KND Studio",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              toTheMoon();
                            },
                            child: new Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    new Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.65,
                                      child: new Image.asset(
                                        'assets/images/mission.jpeg',
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Mission to the moon",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              salmon();
                            },
                            child: new Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    new Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.65,
                                      child: new Image.asset(
                                        'assets/images/salmon.jpeg',
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Salmon Podcast",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              getTalks();
                            },
                            child: new Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    new Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.65,
                                      child: new Image.asset(
                                        'assets/images/gettalk.jpeg',
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "GetTalks Podcast",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              ghost();
                            },
                            child: new Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    new Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.65,
                                      child: new Image.asset(
                                        'assets/images/ghostradio.jpeg',
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "The Ghost Radio",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              pipe();
                            },
                            child: new Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    new Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.65,
                                      child: new Image.asset(
                                        'assets/images/pipe.jpeg',
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "ไปป์เล่าเรื่องผี",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              ajarn();
                            },
                            child: new Card(
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    new Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.65,
                                      child: new Image.asset(
                                        'assets/images/ajarn.jpeg',
                                        height: 60.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "อาจารย์ยอด",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
}
