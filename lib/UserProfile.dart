//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vhelp_test/AccountScreen.dart';
import 'package:vhelp_test/model/userInfo.dart';

User? user = FirebaseAuth.instance.currentUser;

class UserPage extends StatefulWidget {
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
  /*Future Result(User? user) {
    return FirebaseFirestore.instance
        .collection("Accounts")
        .doc(user!.uid)
        .get()
        .then((value) {
      value.data();
    });
    //print(_userCollection);
  }*/

  @override
  Widget build(BuildContext context) {
    //final FirebaseAuth auth = FirebaseAuth.instance;
    //print(Result(user).);

    CollectionReference users =
        FirebaseFirestore.instance.collection('Accounts');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(user!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              appBar: AppBar(
                title: Text('Profile'),
              ),
              body: Column(children: [
                Container(
                  child: Column(children: [
                    Text("Username: ${data['username']}"),
                    Text("Email: ${user!.email}"),
                    Text("Firstname: ${data['fname']}"),
                    Text("Lastname: ${data['lname']}"),
                    Text("Nickname: ${data['nickname']}"),
                    Text("Date of Birth: ${data['dob']}"),
                    Text("Phone: ${data['phone']}"),
                    ElevatedButton(
                        onPressed: () {
                          _signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MyApp()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text('Logout')),
                    ElevatedButton(
                        onPressed: () {
                          _EditProfile();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Account Warning!'),
                                      content: const Text(
                                          'Successfully! You have edited your profile.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ]));
                        },
                        child: Text('Edit Profile')),
                    ElevatedButton(
                        onPressed: () {
                          _DeleteUser();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ));
                        },
                        child: Text('Delete Account'))
                  ]),
                ),
              ]));
        }

        return Scaffold(
          appBar: AppBar(title: Text("Loading...")),
        );
      },
    );
  }

  /*Scaffold(
        appBar: AppBar(
          title: Text("UserProfile"),
        ),
        body: Column(
          children: [
           // Container(child: Result()),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                ])
          ],
        ));
  }*/

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void _EditProfile() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("Accounts")
        .doc(user!.uid)
        .update({"username": "Test 1"}).then((_) {
      print("success");
    });
  }

  void _DeleteUser() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("Accounts")
        .doc(user!.uid)
        .delete()
        .then((_) {});
  }
}
