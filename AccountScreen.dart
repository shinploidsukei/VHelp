import 'package:flutter/material.dart';
import 'screens/register.dart';
import 'Login.dart';
import 'Start.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blueGrey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: MyStatelessWidget(),
    ));
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/iceberg.png',
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
                  MaterialPageRoute(builder: (context) => Register()),
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
                  MaterialPageRoute(builder: (context) => LoginDemo()),
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
    );
  }
}
