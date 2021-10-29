import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';

class Symptoms extends StatelessWidget {


  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.black,
    ),
    home: SymptomsPage(),
  );
}

class SymptomsPage extends StatefulWidget {
  @override
  SymptomsPageState createState() => SymptomsPageState();
}

class SymptomsPageState extends State<SymptomsPage> {
  int index = 0;

  _launchURL() async {
    const url =
        'https://www.helpguide.org/articles/depression/depression-symptoms-and-warning-signs.htm';
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
                      image: AssetImage('assets/images/symptom.jpg'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Depression Symptoms and Warning Signs',
              style: TextStyle(fontSize: 25, color: Colors.blue.shade700,fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              '           Depression varies from person to person, but there are some common signs and symptoms. It’s important to remember that these symptoms can be part of life’s normal lows. But the more symptoms you have, the stronger they are, and the longer they’ve lasted—the more likely it is that you’re dealing with depression.',
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