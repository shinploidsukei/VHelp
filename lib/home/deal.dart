import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';

class Deal extends StatelessWidget {


  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.black,
    ),
    home: DealPage(),
  );
}

class DealPage extends StatefulWidget {
  @override
  DealPageState createState() => DealPageState();
}

class DealPageState extends State<DealPage> {
  int index = 0;

  _launchURL() async {
    const url =
        'https://thiswayup.org.au/learning-hub/depression-explained/';
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
              colors: [Colors.white, Colors.white],
            )),
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
                color: Colors.blue.shade700,
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
                      image: AssetImage('assets/images/what.jpg'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'How to deal with depression when you feel blue',
              style: TextStyle(fontSize: 25, color: Colors.blue.shade700,fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              '           There are a range of ways to deal with depression, and often they are best used in conjunction with each other. The primary medical options are Cognitive Behavioural Therapy (CBT), antidepressant medication, and in some severe cases, Electroconvulsive Therapy (ECT). Education and coping strategies are also important when learning to manage your depression.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2C72CE),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: _launchURL,
                child: Text(
                  'Read More',
                  style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'RobotoMono'),
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