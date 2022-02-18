import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vhelp_test/AccountScreen.dart';
import 'package:restart_app/restart_app.dart';
import 'package:vhelp_test/drawer_sidebar.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
                  title: Text(S.of(context)!.profile,
                      style: TextStyle(color: Colors.black54, fontSize: 22)),
                  iconTheme: IconThemeData(color: Colors.black54),
                  backgroundColor: Colors.cyan.shade100,
                  actions: [
                    LanguagePickerWidget(),
                    //const SizedBox(width: 12),
                  ],
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.cyan.shade100,
                    Colors.blueGrey.shade100
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Image.network('$data[profile url]'),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: changePic,
                              child: Column(
                                children: [
                                  image2 != null && imageUrl.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 50.0,
                                          backgroundImage:
                                              NetworkImage(imageUrl))
                                      : CircleAvatar(
                                          radius: 50.0,
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            height: 50.0,
                            //width: 0,
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //const Icon(Icons.person_outline),
                                new Text(
                                  S.of(context)!.username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                                new Text("${data['username']}  ",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            height: 50.0,
                            //width: 0,
                            padding: EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //const Icon(Icons.person_outline),
                                new Text(
                                  S.of(context)!.email,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                                new Text(
                                  "${user!.email}  ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            height: 50,
                            //width: 0,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //const Icon(Icons.person_outline),
                                new Text(
                                  S.of(context)!.firstname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                                new Text(
                                  "${data['fname']}  ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            height: 50,
                            //width: 0,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //const Icon(Icons.person_outline),
                                new Text(
                                  S.of(context)!.lastname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                                new Text(
                                  "${data['lname']}  ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            height: 50,
                            //width: 0,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //const Icon(Icons.person_outline),
                                new Text(
                                  S.of(context)!.nickname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                                new Text(
                                  "${data['nickname']}  ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            height: 50,
                            //width: 0,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //const Icon(Icons.person_outline),
                                new Text(
                                  S.of(context)!.dob,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                                new Text(
                                  "${data['dob']}  ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            height: 50,
                            //width: 0,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //const Icon(Icons.person_outline),
                                new Text(
                                  S.of(context)!.phone,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey),
                                ),
                                new Text(
                                  "${data['phone']}  ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
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
                          //delete
                        ]),
                  ),
                ),
                ),
                floatingActionButton: SpeedDial(
                  animatedIcon: AnimatedIcons.menu_close,
                  animatedIconTheme: IconThemeData(size: 22),
                  backgroundColor: Colors.cyan.shade600,
                  visible: true,
                  curve: Curves.bounceIn,
                  children: [
                    SpeedDialChild(
                        child: Icon(Icons.lock_open),
                        backgroundColor: Colors.cyan.shade100,
                        onTap: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          await pref.clear();
                          _signOut();
                          //Restart.restartApp();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) => MyApp()),
                          );
                        },
                        label: S.of(context)!.logout,
                        labelStyle: TextStyle(),
                        labelBackgroundColor: Colors.white),
                    SpeedDialChild(
                        child: Icon(Icons.delete),
                        backgroundColor: Colors.cyan.shade100,
                        onTap: () async {
                          _DeleteUser();
                        },
                        label: S.of(context)!.deleteAccount,
                        labelStyle: TextStyle(),
                        labelBackgroundColor: Colors.white)
                  ],
                ));

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
            //title: Text(S.of(context)!.chooseProfile),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  " + S.of(context)!.chooseProfile,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: (Icon(Icons.close))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      child: Text(S.of(context)!.camera,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)),
                      onPressed: () {
                        image = pickImageCam();
                        //print(image);
                      }),
                  TextButton(
                      child: Text(S.of(context)!.gallery,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey)),
                      onPressed: () => pickImageGal()),
                ],
              ),
            ],
          );
        });
  }

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

  Future<void> _DeleteUser() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context)!.warning),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(S.of(context)!.warning1),
                  Text(S.of(context)!.warning2),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(S.of(context)!.back),
                  onPressed: () {
                    Navigator.of(context).pop();
                    //print(image);
                  }),
              TextButton(
                  child: Text(S.of(context)!.deleteit),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.clear();
                    _DeleteMe();
                    // Restart.restartApp();
                  })
            ],
          );
        });
  }

  void _DeleteMe() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    print(firebaseUser!.uid);
    FirebaseFirestore.instance
        .collection("Accounts")
        .doc(user!.uid)
        .delete()
        .then((_) {
      print("success");
    });
    DeleteFromAuth();
    //Restart.restartApp();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => MyApp()),
    );
  }

  void DeleteFromAuth() async {
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
