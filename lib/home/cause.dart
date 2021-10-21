import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';

class Cause extends StatelessWidget {


  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
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
        body: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.blue.shade100],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
    child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black87,
                ),
                alignment: Alignment.topLeft,
                hoverColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                        image: AssetImage('assets/images/cause.jpg'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Causes and Effects of Depression',
                style: TextStyle(fontSize: 27, color: Colors.black87,fontWeight: FontWeight.bold),
              ),
              const Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                '           Many potential causes for depression exist. It can be genetic, meaning the patient has a family history of depression. Personal trauma and sources of stress, such as a failed relationship or a lost job, can also cause depression. Social isolation as the result of conflict with family and friends can be a contributory factor, and certain medications, such as high blood pressure medication, have depression listed as a possible side effect.',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: _launchURL,
                  child: Text(
                    'More..',
                    style: TextStyle(color: Colors.black87, fontSize: 20,fontFamily: 'RobotoMono'),
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
    );
  }
}



