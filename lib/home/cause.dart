import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CausePage extends StatefulWidget {
  @override
  CausePageState createState() => CausePageState();
}

class CausePageState extends State<CausePage> {
  int index = 0;

  _launchURL() async {
    /*const url = 'https://www.psychguides.com/depression/';*/
    if (await canLaunch(S.of(context)!.causeLink)) {
      await launch(S.of(context)!.causeLink);
    } else {
      throw 'Could not launch $S.of(context)!.causeLink';
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
                      icon: Icon(Icons.arrow_back_ios, color: Colors.blue.shade700),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()),
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
                          /*IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.blue.shade700,
                            ),
                            alignment: Alignment.topLeft,
                            hoverColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                          ),*/
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/cause.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            S.of(context)!.topic3,
                            style: TextStyle(
                                fontSize: 25,
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
                            S.of(context)!.content3,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF2C72CE),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              onPressed: _launchURL,
                              child: Text(
                                S.of(context)!.readbutton,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'RobotoMono'),
                                //textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
