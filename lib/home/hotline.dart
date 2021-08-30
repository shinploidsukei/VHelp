import 'package:flutter/material.dart';
import 'package:vhelp_test/Content.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
  Future<void> _makePhoneCall(command)async{
    if(await canLaunch(command)){
      await launch(command);
    }else{
      print('Could not launch $command');
    }
  }
  _launchURL() async {
    const url =
        'https://www.dmh.go.th/main.asp';
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
        title: Text("Hotline"),
        backgroundColor: Colors.blueGrey,
        elevation: 4.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
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
                height: 10,
              ),
              Text(
                'Department of Mental Health',
                style: TextStyle(fontSize: 18 ,color: Colors.black54,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/hotline.jpg'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '           Department of Mental Health Hotline 1323 will provide people with fast and effective mental health counseling. In the future, Thai people will be in good mental health and happy. The number of lines on the Mental Health Hotline 1323 will be increased to accommodate the growing demand.',
                style: TextStyle(fontSize: 15 ,color: Colors.black54),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: TextButton(
                  onPressed: _launchURL,
                  child: Text(
                    'Go to Website',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            child: Icon(Icons.call),
            onPressed: () => setState((){
              launch(('tel://$command'));
            }),
          ),
        )
    );
  }
}


