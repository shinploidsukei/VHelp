import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';

class Hotline extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: HotlinePage(),
      );
}

class HotlinePage extends StatefulWidget {
  @override
  HotlinePageState createState() => HotlinePageState();
}

class HotlinePageState extends State<HotlinePage> {
  int index = 0;
  final number = '1323';
  final command = '1323';
  // ignore: unused_element
  Future<void> _makePhoneCall(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Could not launch $command');
    }
  }

  _launchURL() async {
    const url = 'https://www.dmh.go.th/main.asp';
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
                      image: AssetImage('assets/images/hotline.jpg'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Hotline',
                style: TextStyle(fontSize: 25, color: Colors.blue.shade700,fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Department of Mental Health',
              style: TextStyle(fontSize: 20, color: Colors.blue.shade700,fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              '           Department of Mental Health Hotline 1323 will provide people with fast and effective mental health counseling. In the future, Thai people will be in good mental health and happy. The number of lines on the Mental Health Hotline 1323 will be increased to accommodate the growing demand.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 50, //height of button
                width: 150, //width of button
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.call,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  label: Text(
                    'Call',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: () => setState(
                    () {
                      launch(('tel://$command'));
                    },
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 50, //height of button
                width: 150, //width of button
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.web,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  label: Text(
                    'Website',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onPressed: _launchURL,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade700,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
