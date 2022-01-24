//import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vhelp_test/AccountScreen.dart';
import 'package:restart_app/restart_app.dart';
import 'package:vhelp_test/drawer_sidebar.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

User? user = FirebaseAuth.instance.currentUser;
final urlImage = "";

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
  static var image1 = urlImage;
  var image;
  late String imageUrl;
  final _storage = FirebaseStorage.instance;
  var image2;

  //FirebaseStorage storage = FirebaseStorage.instance;
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
    image2 = NavigationDrawerWidget.image1;
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
          imageUrl = data['profile url'];
          return Scaffold(
              appBar: AppBar(
                title: Text('Profile'),
              ),
              body: Column(children: [
                Container(
                  child: Column(children: [
                    // Image.network('$data[profile url]'),

                    GestureDetector(
                        onTap: changePic,
                        child: Column(
                          children: [
                            image2 != null
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(imageUrl))
                                /*ClipOval(
                              child: 
                                  SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: Image.file(image!)))*/
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        'assets/images/iceberg.png')),
                            /*    ? FutureBuilder(
                                    future: _loadImages(),
                                    builder: (context,
                                        AsyncSnapshot<
                                                List<Map<String, dynamic>>>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        //print(snapshot.data);
                                        return ListView.builder(
                                          itemCount: snapshot.data?.length ?? 0,
                                          itemBuilder: (context, index) {
                                            final Map<String, dynamic> image =
                                                snapshot.data![index];

                                            return Card(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: ListTile(
                                                dense: false,
                                                leading:
                                                    Image.network(image['url']),
                                                title:
                                                    Text(image['uploaded_by']),
                                                subtitle:
                                                    Text(image['description']),
                                              ),
                                            );
                                          },
                                        );
                                      }

                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  )*/

                            /*? ClipOval(
                                    child: SizedBox.fromSize(
                                        size: Size.fromRadius(30),
                                        child: Image.file(image!)))
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        'assets/images/iceberg.png')),*/
                          ],
                        )),
                    Text("Username: ${data['username']}"),
                    Text("Email: ${user!.email}"),
                    Text("Firstname: ${data['fname']}"),
                    Text("Lastname: ${data['lname']}"),
                    Text("Nickname: ${data['nickname']}"),
                    Text("Date of Birth: ${data['dob']}"),
                    Text("Phone: ${data['phone']}"),
                    ElevatedButton(
                        onPressed: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          await pref.clear();
                          _signOut();
                          Restart.restartApp();
                          /*Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) => MyApp()),
                          );*/
                        },
                        child: Text('Logout')),
                    /*ElevatedButton(
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
                        child: Text('Edit Profile')),*/
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
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

  Future<String> pickImageCam() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      // if (image == null) return;
      final imageTemporary = File(image!.path);
      if (image != null) {
        var snapshot = await _storage
            .ref()
            .child('VHelpProfile/DisplayProfilePic')
            .putFile(imageTemporary);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
          users
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'profile url': imageUrl});
          print(imageUrl);
        });
      } else {
        print('No Path Received');
      }
      // setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    return imageUrl;
  }

  Future pickImageGal() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      // if (image == null) return;
      final imageTemporary = File(image!.path);
      if (image != null) {
        var snapshot = await _storage
            .ref()
            .child('VHelpProfile/DisplayProfilePic')
            .putFile(imageTemporary);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
          users
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'profile url': imageUrl});
          print(imageUrl);
        });
      } else {
        print('No Path Received');
      }
      // setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    return imageUrl;
  }

  Future<void> changePic() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choose your profile image'),
            actions: <Widget>[
              TextButton(
                  child: const Text('From Camera'),
                  onPressed: () {
                    image = pickImageCam();
                    //print(image);
                  }),
              TextButton(
                  child: const Text('From Gallery'),
                  onPressed: () => pickImageGal())
            ],
          );
        });
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

  /*void _EditProfile() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("Accounts")
        .doc(user!.uid)
        .update({"username": "Test 1"}).then((_) {
      print("success");
    });
  }*/

  void _DeleteUser() async {
    // ignore: unused_local_variable
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("Accounts")
        .doc(user!.uid)
        .delete()
        .then((_) {});
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }
}



