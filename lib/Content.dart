import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/home/cause.dart';
import 'package:vhelp_test/home/hotline.dart';
import 'package:vhelp_test/home/symptoms.dart';
import 'package:vhelp_test/no_internet.dart';
import 'connectivity_provider.dart';
import 'drawer_sidebar.dart';
import 'package:vhelp_test/home/depression.dart';
import 'package:vhelp_test/home/deal.dart';
//import 'package:scroll_to_example/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();

  @override
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? Scaffold(
                  backgroundColor: Colors.white,
                  drawer: NavigationDrawerWidget(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black54),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Text("VHelp",
                        style: TextStyle(color: Colors.black54, fontSize: 22)),
                  ),
                  /*floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.arrow_downward),
                    onPressed: scrollDown,
                  ),
                   */
                  body: Container(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: [
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Depression()),
                              );
                            },
                            child: new Container(
                              //1
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/what.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Depression()),
                              );
                            },
                            child: new Container(
                              padding: const EdgeInsets.all(30.0),
                              color: Colors.amber[100],
                              alignment: Alignment.center,
                              child: Text(
                                'What is depression?',
                                style: TextStyle(
                                  fontSize: 20,
                                  foreground: Paint()..color = Colors.black54,
                                ),
                              ),
                              transform: Matrix4.rotationZ(0.1),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hotline()),
                              );
                            },
                            child: new Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.pink[50],
                              alignment: Alignment.center,
                              child: Text(
                                'Hotline',
                                style: TextStyle(
                                  fontSize: 20,
                                  foreground: Paint()..color = Colors.black54,
                                ),
                              ),
                              transform: Matrix4.rotationZ(-0.1),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Hotline(),
                                  ));
                            },
                            child: new Container(
                              //2
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/hotline.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Cause(),
                                  ));
                            },
                            child: new Container(
                              //3
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/cause.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Cause(),
                                  ));
                            },
                            child: new Container(
                              constraints: BoxConstraints.expand(
                                height: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .fontSize! *
                                        1.1 +
                                    200.0,
                              ),
                              padding: const EdgeInsets.all(30.0),
                              color: Colors.lightGreen[100],
                              alignment: Alignment.center,
                              child: Text(
                                'Causes and Effects of Depression',
                                style: TextStyle(
                                  fontSize: 20,
                                  foreground: Paint()..color = Colors.black54,
                                ),
                              ),
                              transform: Matrix4.rotationZ(0.1),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Symptoms(),
                                  ));
                            },
                            child: new Container(
                              constraints: BoxConstraints.expand(
                                height: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .fontSize! *
                                        1.1 +
                                    200.0,
                              ),
                              padding: const EdgeInsets.all(30.0),
                              color: Colors.lightBlue[100],
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Depression Symptoms and Warning Signs',
                                style: TextStyle(
                                  fontSize: 20,
                                  foreground: Paint()..color = Colors.black54,
                                ),
                              ),
                              transform: Matrix4.rotationZ(-0.1),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Symptoms(),
                                  ));
                            },
                            child: new Container(
                              //4
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/symptom.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Deal(),
                                  ));
                            },
                            child: new Container(
                              //5
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/what.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Deal(),
                                  ));
                            },
                            child: new Container(
                              constraints: BoxConstraints.expand(
                                height: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .fontSize! *
                                        1.1 +
                                    200.0,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.purple[100],
                              alignment: Alignment.center,
                              child: Text(
                                'How to deal with depression when you feel blue',
                                style: TextStyle(
                                  fontSize: 20,
                                  foreground: Paint()..color = Colors.black54,
                                ),
                              ),
                              transform: Matrix4.rotationZ(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : NoInternet();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void scrollUp() {
    final double start = 0;

    controller.jumpTo(start);
    //controller.animateTo(start, duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  void scrollDown() {
    final double end = controller.position.maxScrollExtent;

    controller.jumpTo(end);
    //controller.animateTo(end, duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}
