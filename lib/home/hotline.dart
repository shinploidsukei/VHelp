import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HotlinePage extends StatefulWidget {
  @override
  HotlinePageState createState() => HotlinePageState();
}

class HotlinePageState extends State<HotlinePage> {
  int index = 0;
  final number = '1323';
  final command = '1323';
  // ignore: unused_element
  Future<void> _makePhoneCall(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch $command');
    }
  }

  _launchURL() async {
    const url = 'https://www.dmh.go.th/main.asp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Colors.blue.shade700),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                    //iconTheme: IconThemeData(color: Colors.blue.shade700),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    actions: [
                      LanguagePickerWidget(),
                      //const SizedBox(width: 12),
                    ],
                  ),
                  body: Container(
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [Colors.white, Colors.white],
                    )),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/hotline.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            S.of(context)!.topic2,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            S.of(context)!.topic2_1,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            S.of(context)!.content2,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              height: 50, //height of button
                              width: 150, //width of button
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                label: Text(
                                  S.of(context)!.callbutton,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onPressed: () => setState(
                                  () {
                                    launch(('tel://$command'));
                                  },
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green.shade600,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(40.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              height: 50, //height of button
                              width: 150, //width of button
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.web,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                label: Text(
                                  S.of(context)!.websitebutton,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onPressed: _launchURL,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade700,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(40.0),
                                  ),
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
