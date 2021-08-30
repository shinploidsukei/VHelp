import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';

class Symptoms extends StatelessWidget {
  //static final String title = 'Date (Range) & Time';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    //title: title,
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
      appBar: AppBar(
        title: Text("Depression Symptoms and Warning Signs"),
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
                        image: AssetImage('assets/images/symptom.jpg'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '           Depression varies from person to person, but there are some common signs and symptoms. It’s important to remember that these symptoms can be part of life’s normal lows. But the more symptoms you have, the stronger they are, and the longer they’ve lasted—the more likely it is that you’re dealing with depression.',
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
