//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vhelp_test/AccountScreen.dart';
import 'package:vhelp_test/model/userInfo.dart';

class UserPage extends StatefulWidget {
  final String name;
  final String urlImage;

  const UserPage({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Accounts").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              print("PloidTest: $snapshot");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(document["username"]),
                      ),
                    ),
                    title: Text(document["fname"] + document["lname"]),
                    subtitle: Text(document["nickname"]),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}


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

/*class UserPage extends StatefulWidget {
  final String name;
  final String urlImage;
  
  const UserPage({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  //UserPage(this.name, this.urlImage);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Accounts');
    UserInfo user = UserInfo();

    return  FutureBuilder(
      future: Provider.of(context).auth.getCurrentUser(),
      builder:(context,snapshot){
      if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
    );
  }
}
 Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${authData.displayName ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${authData.email ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Created: ${DateFormat('MM/dd/yyyy').format(authData.metadata.creationTime)}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        FutureBuilder(
          future: _getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _userCountryController.text = user.homeCountry;
            }
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Home Country: ${_userCountryController.text}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  adminFeature(),
                ],
              ),
            );
          }
        ),
        showSignOut(context, authData.isAnonymous),
        RaisedButton(
          child: Text("Edit User"),
          onPressed: () {
            _userEditBottomSheet(context);
          },
        )
      ],
    );
  }

  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get().then((result) {
          user.homeCountry = result.data['homeCountry'];
          user.admin = result.data['admin'];
    });
  }*/
/*
        Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 Image.network(
                urlImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
                  ElevatedButton(
                      onPressed: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.clear();
                        // ignore: deprecated_member_use
                        sharedPreferences.commit();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => MyApp()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text('Logout'))
                ]));
  }
}*/
