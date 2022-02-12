import 'dart:io' show Platform;
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
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/channel/UC3f2SY4F9zcxY1oxt9AF9WA')) {
        await launch(
            'youtube://www.youtube.com/channel/UC3f2SY4F9zcxY1oxt9AF9WA',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/channel/UC3f2SY4F9zcxY1oxt9AF9WA')) {
          await launch(
              'https:////www.youtube.com/channel/UC3f2SY4F9zcxY1oxt9AF9WA');
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UC3f2SY4F9zcxY1oxt9AF9WA';
        }
      }
    } else {
      const url = 'https://www.youtube.com/channel/UC3f2SY4F9zcxY1oxt9AF9WA';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  knd() async {
    if (Platform.isIOS) {
      if (await canLaunch('youtube://www.youtube.com/c/KNDStudio')) {
        await launch('youtube://www.youtube.com/c/KNDStudio',
            forceSafariVC: false);
      } else {
        if (await canLaunch('https://www.youtube.com/c/KNDStudio')) {
          await launch('https://www.youtube.com/c/KNDStudio');
        } else {
          throw 'Could not launch https://www.youtube.com/c/KNDStudio';
        }
      }
    } else {
      const url = 'https://www.youtube.com/c/KNDStudio';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  toTheMoon() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/c/MissiontotheMoonMedia')) {
        await launch('youtube://www.youtube.com/c/MissiontotheMoonMedia',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/c/MissiontotheMoonMedia')) {
          await launch('https://www.youtube.com/c/MissiontotheMoonMedia');
        } else {
          throw 'Could not launch https://www.youtube.com/c/MissiontotheMoonMedia';
        }
      }
    } else {
      const url = 'https://www.youtube.com/c/MissiontotheMoonMedia';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  salmon() async {
    if (Platform.isIOS) {
      if (await canLaunch('youtube://www.youtube.com/c/SalmonPodcast')) {
        await launch('youtube://www.youtube.com/c/SalmonPodcast',
            forceSafariVC: false);
      } else {
        if (await canLaunch('https://www.youtube.com/c/SalmonPodcast')) {
          await launch('https://www.youtube.com/c/SalmonPodcast');
        } else {
          throw 'Could not launch https://www.youtube.com/c/SalmonPodcast';
        }
      }
    } else {
      const url = 'https://www.youtube.com/c/SalmonPodcast';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  getTalks() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/channel/UC-Ta59DOm6pmkTJ_zCxjkkA')) {
        await launch(
            'youtube://www.youtube.com/channel/UC-Ta59DOm6pmkTJ_zCxjkkA',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/channel/UC-Ta59DOm6pmkTJ_zCxjkkA')) {
          await launch(
              'https://www.youtube.com/channel/UC-Ta59DOm6pmkTJ_zCxjkkA');
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UC-Ta59DOm6pmkTJ_zCxjkkA';
        }
      }
    } else {
      const url = 'https://www.youtube.com/channel/UC-Ta59DOm6pmkTJ_zCxjkkA';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  ghost() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/results?search_query=ghost+radio')) {
        await launch(
            'youtube://www.youtube.com/results?search_query=ghost+radio',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/results?search_query=ghost+radio')) {
          await launch(
              'https://www.youtube.com/results?search_query=ghost+radio');
        } else {
          throw 'Could not launch https://www.youtube.com/results?search_query=ghost+radio';
        }
      }
    } else {
      const url = 'https://www.youtube.com/results?search_query=ghost+radio';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  pipe() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/c/%E0%B9%84%E0%B8%9B%E0%B8%9B%E0%B9%8C%E0%B9%80%E0%B8%A5%E0%B9%88%E0%B8%B2%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%9C%E0%B8%B5')) {
        await launch(
            'youtube://www.youtube.com/c/%E0%B9%84%E0%B8%9B%E0%B8%9B%E0%B9%8C%E0%B9%80%E0%B8%A5%E0%B9%88%E0%B8%B2%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%9C%E0%B8%B5',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/c/%E0%B9%84%E0%B8%9B%E0%B8%9B%E0%B9%8C%E0%B9%80%E0%B8%A5%E0%B9%88%E0%B8%B2%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%9C%E0%B8%B5')) {
          await launch(
              'https://www.youtube.com/c/%E0%B9%84%E0%B8%9B%E0%B8%9B%E0%B9%8C%E0%B9%80%E0%B8%A5%E0%B9%88%E0%B8%B2%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%9C%E0%B8%B5');
        } else {
          throw 'Could not launch https://www.youtube.com/c/%E0%B9%84%E0%B8%9B%E0%B8%9B%E0%B9%8C%E0%B9%80%E0%B8%A5%E0%B9%88%E0%B8%B2%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%9C%E0%B8%B5';
        }
      }
    } else {
      const url =
          'https://www.youtube.com/c/%E0%B9%84%E0%B8%9B%E0%B8%9B%E0%B9%8C%E0%B9%80%E0%B8%A5%E0%B9%88%E0%B8%B2%E0%B9%80%E0%B8%A3%E0%B8%B7%E0%B9%88%E0%B8%AD%E0%B8%87%E0%B8%9C%E0%B8%B5';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  ajarn() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/channel/UCZo5ZB2p-UMqc5e1llZ1RLg')) {
        await launch(
            'youtube://www.youtube.com/channel/UCZo5ZB2p-UMqc5e1llZ1RLg',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/channel/UCZo5ZB2p-UMqc5e1llZ1RLg')) {
          await launch(
              'https://www.youtube.com/channel/UCZo5ZB2p-UMqc5e1llZ1RLg');
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCZo5ZB2p-UMqc5e1llZ1RLg';
        }
      }
    } else {
      const url = 'https://www.youtube.com/channel/UCZo5ZB2p-UMqc5e1llZ1RLg';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
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
                    title: Text(S.of(context)!.sidebar8,
                        style: TextStyle(color: Colors.black54, fontSize: 22)),
                  ),
                  body: Container(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: [
                          new GestureDetector(
                            onTap: () {
                              standPod();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(40)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'assets/images/standpod.jpeg',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    S.of(context)!.stand,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              knd();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'assets/images/knd.png',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    S.of(context)!.knd,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              toTheMoon();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'assets/images/mission.jpeg',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    S.of(context)!.mission,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              salmon();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'assets/images/salmon.jpeg',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    S.of(context)!.salmon,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              getTalks();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'assets/images/gettalk.jpeg',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    S.of(context)!.gettalk,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              ghost();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'assets/images/ghostradio.jpeg',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    S.of(context)!.ghost,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              pipe();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'assets/images/pipe.jpeg',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    S.of(context)!.pipe,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              ajarn();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'assets/images/ajarn.jpeg',
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    S.of(context)!.ajarn_yord,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
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
