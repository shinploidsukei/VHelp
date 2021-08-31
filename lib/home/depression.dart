import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';

class Depression extends StatelessWidget {
  //static final String title = 'Date (Range) & Time';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        //title: title,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: DepressionPage(),
      );
}

class DepressionPage extends StatefulWidget {
  @override
  DepressionPageState createState() => DepressionPageState();
}

class DepressionPageState extends State<DepressionPage> {
  int index = 0;

  _launchURL() async {
    const url =
        'https://www.psychiatry.org/patients-families/depression/what-is-depression';
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
        title: Text("What is depression?"),
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
        child: SingleChildScrollView(
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
                '         Depression (major depressive disorder) is a common and serious medical illness that negatively affects how you feel, the way you think and how you act. Fortunately, it is also treatable. Depression causes feelings of sadness and/or a loss of interest in activities you once enjoyed. It can lead to a variety of emotional and physical problems and can decrease your ability to function at work and at home.',
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '           Depression symptoms can vary from mild to severe and can include:',
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '           • Feeling sad or having a depressed mood\n           • Loss of interest or pleasure in activities once enjoyed\n           • Changes in appetite — weight loss or gain unrelated to dieting\n           • Trouble sleeping or sleeping too much\n           • Loss of energy or increased fatigue\n           • Increase in purposeless physical activity (e.g., inability to sit still, pacing, handwringing) or slowed movements or speech (these actions must be severe enough to be observable by others)\n           • Feeling worthless or guilty\n           • Difficulty thinking, concentrating or making decisions\n           • Thoughts of death or suicide',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(
                height: 20,
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
      ),
    );
  }
}
