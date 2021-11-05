import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/offline.png"))),
          ),
          Text(
            "  No Internet Connection",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.red),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "                You are not connected to the Internet.\n  Make sure your WiFi is on and Airplane mode is off.",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
