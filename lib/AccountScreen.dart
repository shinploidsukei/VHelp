import 'package:flutter/material.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/screens/register.dart';
import 'Login.dart';
import 'Start.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';

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
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline != null) {
          return model.isOnline
              ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.blue.shade200,
                    Colors.blueGrey.shade100
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/art.png',
                        height: 350,
                        width: 350,
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black12, // background
                            onPrimary: Colors.black, // foreground
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black12, // background
                            onPrimary: Colors.black, // foreground
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginDemo()),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black12, // background
                            onPrimary: Colors.black, // foreground
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Start()),
                            );
                          },
                          child: Text(
                            'Login as Guest',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
