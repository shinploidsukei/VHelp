import 'package:flutter/material.dart';

/*
class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final user = userInfo(
      username: ' ',
      fname: ' ',
      lname: ' ',
      nickname: ' ',
      dob: ' ',
      phone: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(userInfo user) => Column(
        children: [
          Text(
            user.fname + ' ' + user.lname,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.nickname,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );

  Widget buildAbout(userInfo user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
}
*/

class UserPage extends StatelessWidget {
  final String name;
  final String urlImage;

  const UserPage({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(name),
          centerTitle: true,
        ),
        /*
        body: Image.network(
          urlImage,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        */
      );
}
