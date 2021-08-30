import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';

class Cause extends StatelessWidget {
  //static final String title = 'Date (Range) & Time';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    //title: title,
    theme: ThemeData(
      primaryColor: Colors.black,
    ),
    home: CausePage(),
  );
}

class CausePage extends StatefulWidget {
  @override
  CausePageState createState() => CausePageState();
}

class CausePageState extends State<CausePage> {
  int index = 0;

  _launchURL() async {
    const url =
        'https://www.psychguides.com/depression/';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Causes and Effects of Depression"),
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
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.blue.shade100],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/cause.jpg'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '           Many potential causes for depression exist. It can be genetic, meaning the patient has a family history of depression. Personal trauma and sources of stress, such as a failed relationship or a lost job, can also cause depression. Social isolation as the result of conflict with family and friends can be a contributory factor, and certain medications, such as high blood pressure medication, have depression listed as a possible side effect.',
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: TextButton(
                  onPressed: _launchURL,
                  child: Text(
                    'More..',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
    );
  }
}
