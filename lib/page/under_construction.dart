import 'package:flutter/material.dart';

class UnderConstruction extends StatefulWidget {
  const UnderConstruction({Key? key}) : super(key: key);

  @override
  _UnderConstructionState createState() => _UnderConstructionState();
}

class _UnderConstructionState extends State<UnderConstruction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blueGrey.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Stack(fit: StackFit.expand, children: [
        Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/iceberg.png',
                  height: 300,
                  width: 300,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                ),
                Text(
                  'Under Construction',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                )
              ],
            )),
          ),
        ]),
      ]),
    ));
  }
}
