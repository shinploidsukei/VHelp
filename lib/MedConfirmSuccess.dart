import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';

class MedConfirmSuccess extends StatelessWidget {
  final String? payload;
  const MedConfirmSuccess({
    Key? key,
    required this.payload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Activity"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          elevation: 4.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            hoverColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  scale: 5,
                  image: AssetImage('assets/images/cut.png'),
                  alignment: Alignment.bottomCenter),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade300, Colors.blueGrey.shade700])),
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const SizedBox(height: 24),
              Text(
                'Do not forget to do your activity!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                payload ?? '',
                style: TextStyle(fontSize: 35),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
