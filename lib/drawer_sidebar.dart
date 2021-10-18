import 'package:flutter/material.dart';
import 'package:vhelp_test/page/diary_page.dart';
import '/page/time_stamp.dart';
import 'Art.dart';
import 'Calendar.dart';
import 'DocNoti.dart';
import 'Music.dart';
import 'Podcast.dart';
import 'MedNoti.dart';
import 'UserProfile.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = 'Levi Ackerman';
    final email = 'levi_ackerman@aot.com';
    final urlImage =
        'https://a-static.besthdwallpaper.com/attack-on-titan-levi-ackerman-for-the-kill-wallpaper-2736x1824-36483_41.jpg';

    return Drawer(
      child: Material(
        color: Colors.cyan.shade200,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: '',
                  urlImage: '',
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Timestamp',
                    icon: Icons.airplane_ticket_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Doctor Notification',
                    icon: Icons.chat,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Medicine Notification',
                    icon: Icons.coffee,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Diary',
                    icon: Icons.auto_stories_rounded,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Calendar',
                    icon: Icons.event_note_rounded,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Art Therapy',
                    icon: Icons.design_services,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Music Therapy',
                    icon: Icons.audiotrack_rounded,
                    onClicked: () => selectedItem(context, 6),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Podcast',
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

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
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
    final color = Colors.white;
    final hoverColor = Colors.white70;

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
          builder: (context) => DocNoti(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MedNoti(),
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
          builder: (context) => Calendar(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => art(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => music(),
        ));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Podcast(),
        ));
        break;
    }
  }
}
