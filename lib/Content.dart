import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'drawer_sidebar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("VHelp"),
      ),
      body: Container(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              Container(
                //1
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/what.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                color: Colors.amber[100],
                alignment: Alignment.center,
                child: Text('What is depression?',
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..color = Colors.black54,
                  ),
                ),
                transform: Matrix4.rotationZ(0.1),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.pink[50],
                alignment: Alignment.center,
                child: Text('Hotline',
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..color = Colors.black54,
                  ),
                ),
                transform: Matrix4.rotationZ(-0.1),
              ),
              Container(
                //2
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/hotline.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                //3
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/cause.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                constraints: BoxConstraints.expand(
                  height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 200.0,
                ),
                padding: const EdgeInsets.all(30.0),
                color: Colors.lightGreen[100],
                alignment: Alignment.center,
                child: Text('Causes and Effects of Depression',
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..color = Colors.black54,
                  ),
                ),
                transform: Matrix4.rotationZ(0.1),
              ),
              Container(
                constraints: BoxConstraints.expand(
                  height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 200.0,
                ),
                padding: const EdgeInsets.all(30.0),
                color: Colors.lightBlue[100],
                alignment: Alignment.centerRight,
                child: Text('Depression\'s Symptoms',
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..color = Colors.black54,
                  ),
                ),
                transform: Matrix4.rotationZ(-0.1),
              ),
              Container(
                //4
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/symptom.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                //5
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/images/what.jpg'),
                        fit: BoxFit.cover)),
              ),
              Container(
                constraints: BoxConstraints.expand(
                  height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 200.0,
                ),
                padding: const EdgeInsets.all(8.0),
                color: Colors.purple[100],
                alignment: Alignment.center,
                child: Text('How to deal with depression when you feel blue',
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..color = Colors.black54,
                  ),
                ),
                transform: Matrix4.rotationZ(0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
