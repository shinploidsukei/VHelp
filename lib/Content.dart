import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:vhelp_test/widget/sound_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flexible/flexible.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();

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
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline) {
        return model.isOnline
            ? ScreenFlexibleWidget(
                child: Builder(builder: (BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  drawer: NavigationDrawerWidget(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black54),
                    backgroundColor: Colors.white,
                    //elevation: 0,
                    title: Text(S.of(context)!.title_VHelp,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: flexible(context, 22.0))),
                    actions: [
                      SoundPickerWidget(),
                      LanguagePickerWidget()
                      //const SizedBox(width: 12),
                    ],
                    elevation: 0,
                  ),
                  body: Container(
                    child: Container(
                      padding: EdgeInsets.all(flexible(context, 20.0)),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: <Widget>[
                          //1
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DepressionPage()),
                              );
                            },
                            child: new Container(
                              //1
                              width: double.infinity,
                              height: flexible(context, 250.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(flexible(context, 20.0)),
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/what.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          //2
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DepressionPage()),
                              );
                            },
                            child: new Container(
                              padding: EdgeInsets.all(flexible(context, 30.0)),
                              //color: Colors.cyan.shade500,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.cyan.shade400,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(flexible(context, 30.0)),
                                  bottomLeft: Radius.circular(flexible(context, 30.0)),
                                ),
                              ),
                              child: Text(
                                S.of(context)!.topic1,
                                style: TextStyle(
                                  fontSize: flexible(context, 17.0),
                                  foreground: Paint()..color = Colors.black54,
                                ),
                              ),
                              transform: Matrix4.rotationZ(flexible(context, 0.1)),
                            ),
                          ),
                          //3
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HotlinePage()),
                              );
                            },
                            child: new Container(
                              padding: EdgeInsets.all(flexible(context, 8.0)),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.cyan.shade200,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(flexible(context, 30.0)),
                                  bottomRight: Radius.circular(flexible(context, 30.0)),
                                ),
                              ),
                              child: Text(
                                S.of(context)!.topic2,
                                style: TextStyle(
                                  fontSize: flexible(context, 17.0),
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
                                    builder: (context) => HotlinePage(),
                                  ));
                            },
                            child: new Container(
                              //2
                              width: double.infinity,
                              height: flexible(context, 250.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(flexible(context, 20.0)),
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
                                    builder: (context) => CausePage(),
                                  ));
                            },
                            child: new Container(
                              //3
                              width: double.infinity,
                              height: flexible(context, 250.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(flexible(context, 20.0)),
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
                                    builder: (context) => CausePage(),
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
                              padding: EdgeInsets.all(flexible(context, 30.0)),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.cyan.shade300,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(flexible(context, 30.0)),
                                  bottomLeft: Radius.circular(flexible(context, 30.0)),
                                ),
                              ),
                              child: Text(
                                S.of(context)!.topic3,
                                style: TextStyle(
                                  fontSize: flexible(context, 17.0),
                                  foreground: Paint()..color = Colors.black54,
                                ),
                              ),
                              transform: Matrix4.rotationZ(flexible(context, 0.1)),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SymptomsPage(),
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
                              padding: EdgeInsets.all(flexible(context, 30.0)),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.cyan.shade100,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(flexible(context, 30.0)),
                                  bottomRight: Radius.circular(flexible(context, 30.0)),
                                ),
                              ),
                              child: Text(
                                S.of(context)!.topic4,
                                style: TextStyle(
                                  fontSize: flexible(context, 17.0),
                                  foreground: Paint()..color = Colors.black54,
                                ),
                              ),
                              transform: Matrix4.rotationZ(flexible(context, -0.1)),
                            ),
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SymptomsPage(),
                                  ));
                            },
                            child: new Container(
                              //4
                              width: double.infinity,
                              height: flexible(context, 250.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(flexible(context, 20.0)),
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
                                    builder: (context) => DealPage(),
                                  ));
                            },
                            child: new Container(
                              //5
                              width: double.infinity,
                              height: flexible(context, 250.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(flexible(context, 20.0)),
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
                                    builder: (context) => DealPage(),
                                  ));
                            },
                            child: new Container(
                              padding: EdgeInsets.all(flexible(context, 30.0)),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.cyan.shade200,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(flexible(context, 30.0)),
                                  bottomLeft: Radius.circular(flexible(context, 30.0)),
                                ),
                              ),
                              child: Text(
                                S.of(context)!.topic5,
                                style: TextStyle(
                                  fontSize: flexible(context, 17.0),
                                  foreground: Paint()..color = Colors.black54,
                                ),
                              ),
                              transform: Matrix4.rotationZ(flexible(context, 0.1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }))
            : NoInternet();
      }
      return Container(
        child: Center(
          child: NoInternet(),
        ),
      );
    });
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

  // ignore: unused_element
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
