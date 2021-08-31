import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';

class Deal extends StatelessWidget {
  //static final String title = 'Date (Range) & Time';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    //title: title,
    theme: ThemeData(
      primaryColor: Colors.black,
    ),
    home: DealPage(),
  );
}

class DealPage extends StatefulWidget {
  @override
  DealPageState createState() =>DealPageState();
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
      appBar: AppBar(
        title: Text("How to deal with depression when you feel blue"),
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
                      image: AssetImage('assets/images/what.jpg'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '           There are a range of ways to deal with depression, and often they are best used in conjunction with each other. The primary medical options are Cognitive Behavioural Therapy (CBT), antidepressant medication, and in some severe cases, Electroconvulsive Therapy (ECT). Education and coping strategies are also important when learning to manage your depression.',
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
