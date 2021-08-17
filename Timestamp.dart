import 'package:flutter/material.dart';

class timestamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.blueGrey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: TimestampWidget(),
    ));
  }
}

/// This is the stateless widget that the main application instantiates.
class TimestampWidget extends StatelessWidget {
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
            Text(
              'Under Construction',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
    );
  }
}
