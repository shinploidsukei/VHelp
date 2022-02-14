import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/start_regist.dart';
import 'Login.dart';
import 'Start.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:flexible/flexible.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyApp extends StatefulWidget {
  @override
  _MyStatelessWidget createState() => _MyStatelessWidget();
}

/// This is the stateless widget that the main application instantiates.
class _MyStatelessWidget extends State<MyApp> {
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
    Size size = MediaQuery.of(context).size;
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? ScreenFlexibleWidget(
            child: Builder(
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.blue.shade200,
                    Colors.blueGrey.shade100
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/iceberg.png',
                        width: flexible(context, 350.0),
                        height: flexible(context, 350.0),
                      ),
                      SizedBox(
                        height: flexible(context, 70.0),
                      ),
                      Container(
                        //height: flexible(context, 45.0),
                        //width: flexible(context, 180.0),
                        width: size.width * 8,
                        height: size.height * 0.1,
                        padding: EdgeInsets.symmetric(vertical: flexible(context, 15.0), horizontal: flexible(context, 40.0),),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white.withOpacity(0.75),
                            onPrimary: Colors.white.withOpacity(0.75),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StartRegist()),
                            );
                          },
                          child: Text(
                            'SIGNUP',
                            style: TextStyle(color: Colors.blueGrey, fontSize: flexible(context, 15.0),),
                          ),
                        ),
                      ),
                      Container(
                        //height: flexible(context, 45.0),
                        //width: flexible(context, 180.0),
                        width: size.width * 8,
                        height: size.height * 0.1,
                        padding: EdgeInsets.symmetric(vertical: flexible(context, 15.0), horizontal: flexible(context, 40.0),),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.withOpacity(0.3),
                            onPrimary: Colors.blue.withOpacity(0.3),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginDemo()),
                            );
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white, fontSize: flexible(context, 15.0),),
                          ),
                        ),
                      ),
                      Container(
                        //height: flexible(context, 45.0),
                        //width: flexible(context, 180.0),
                        width: size.width * 8,
                        height: size.height * 0.1,
                        padding: EdgeInsets.symmetric(vertical: flexible(context, 15.0), horizontal: flexible(context, 40.0),),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.withOpacity(0.3),
                            onPrimary: Colors.blue.withOpacity(0.3),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                          ),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("isAno", true);
                            signInAno();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Start()),
                            );
                          },
                          child: Text(
                            'LOGIN AS GUEST',
                            style: TextStyle(color: Colors.white, fontSize: flexible(context, 15.0),),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
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

  Future signInAno() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? userAno = result.user;
      print("PloidTest: ${userAno!.uid}");
      return userAno;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
