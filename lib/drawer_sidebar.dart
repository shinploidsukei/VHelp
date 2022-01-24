import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/page/diary_page.dart';
import 'package:vhelp_test/page/doctor_calendar_page.dart';
import 'package:vhelp_test/page/under_construction.dart';
import '/page/time_stamp.dart';
import 'Art.dart';
import 'Music.dart';
import 'Podcast.dart';
import 'MedNoti.dart';
import 'UserProfile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'AccountScreen.dart';

CollectionReference users = FirebaseFirestore.instance.collection('Accounts');
final name = "raythada";
final email = user!.email;
//final email = user!.email;
final urlImage = "";
final padding = EdgeInsets.symmetric(horizontal: 20);

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  static var image1 = urlImage;
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  var image2;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    image2 = NavigationDrawerWidget.image1;
    return Drawer(
      child: Material(
        color: Colors.blue.shade100,
        child: ListView(
          children: <Widget>[
            checkUser(user),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: S.of(context)!.sidebar1,
                    icon: Icons.airplane_ticket_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context)!.sidebar2,
                    icon: Icons.chat,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context)!.sidebar3,
                    icon: Icons.coffee,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context)!.sidebar4,
                    icon: Icons.auto_stories_rounded,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context)!.sidebar5,
                    icon: Icons.event_note_rounded,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context)!.sidebar6,
                    icon: Icons.design_services,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context)!.sidebar7,
                    icon: Icons.audiotrack_rounded,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: S.of(context)!.sidebar8,
                    icon: Icons.mic_external_on,
                    onClicked: () => selectedItem(context, 7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkUser(User? userTest) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userTest != null) {
            print(userTest.isAnonymous);
            if (userTest.isAnonymous == true) {
              return Container(
                padding: padding,
                child: Column(
                  children: [
                    Text("You are log in as guest"),
                    ElevatedButton(
                        onPressed: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          await pref.clear();
                          _signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MyApp()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text('Logout')),
                  ],
                ),
              );
            } else {
              return FutureBuilder<DocumentSnapshot>(
                  future: users.doc(user!.uid).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        print("has data");
                      }
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      var name1 = data['username'].toString();
                      var url1 = data['profile url'];
                      return buildHeader(
                        urlImage: url1,
                        name: name1,
                        email: email!,
                        onClicked: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserPage(
                            name: "",
                            urlImage: "",
                          ),
                        )),
                      );
                    } else {
                      print("data not exist");
                    }
                    return Scaffold(
                      appBar: AppBar(title: Text("Loading...")),
                    );
                  });
            }
          } else {
            return Scaffold(
              body: Text('null data'),
            );
          }
        });
  }

  Widget buildHeader({
    //required String urlImage,
    required String name,
    required String email,
    required String urlImage,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              GestureDetector(
                  child: Column(
                children: [
                   image2 != null
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: new NetworkImage(urlImage))

                      /*ClipOval(
                              child: 
                                  SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: Image.file(image!)))*/
                      : CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/iceberg.png')),
                ],
              )),
              //CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    final color = Colors.black54;
    final hoverColor = Colors.black54;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => timeStamp(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DoctorCalendar(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MedNotiPage(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          //builder: (context) => DiaryLogPage(),
          builder: (context) => DiaryPage(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UnderConstruction(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ArtTherapyPage(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => music(),
        ));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PodcastPage(),
        ));
        break;
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
