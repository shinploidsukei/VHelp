import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'connectivity_provider.dart';
import 'termservice.dart';
import 'Content.dart';
import 'package:flexible/flexible.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  bool checkBoxValue = false;
  bool _enabled = false;
  bool nextvalue = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    var _onPressed;
    if (_enabled) {
      _onPressed = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      };
    }
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.blue.shade200,
                          Colors.blueGrey.shade100
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Center(
                            child: Container(
                                width: 450,
                                height: 450,
                                child:
                                    Image.asset('assets/images/iceberg.png')),
                          ),
                        ),
                        ElevatedButton(
                            child: const Text('Let Me Help You',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            onPressed: _onPressed,
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 30))),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => TermService()));
                            },
                            child: Row(
                              children: [
                                new Checkbox(
                                  value: _enabled,
                                  onChanged: (nextvalue) {
                                    setState(() {
                                      _enabled = nextvalue!;
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                                Text('Terms and Conditions'),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            )),
                      ],
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
