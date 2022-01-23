import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/screens/register.dart';
import '../Login.dart';
import '../model/userInfo.dart';

// ignore: camel_case_types
class profileForm extends StatefulWidget {
  const profileForm({Key? key}) : super(key: key);

  @override
  _profileFormState createState() => _profileFormState();
}

// ignore: camel_case_types
class _profileFormState extends State<profileForm> {
  final formkey = GlobalKey<FormState>();
  userInfo myInfo = userInfo(
      username: '',
      fname: '',
      lname: '',
      nickname: '',
      dob: '',
      phone: '',
      picUrl: '');
 

  DateTime? myDate;
  String getText() {
    // ignore: unnecessary_null_comparison
    if (myDate == null) {
      return '  Date of Birth';
    } else {
      return DateFormat('dd/MM/yyyy').format(myDate!);
    }
  }

  //firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _myCollection =
      FirebaseFirestore.instance.collection('Accounts');

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ? FutureBuilder(
                  future: firebase,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(
                        backgroundColor: Colors.blue.shade100,
                        appBar: AppBar(
                          title: Text('Error'),
                          iconTheme: IconThemeData(color: Colors.black54),
                          backgroundColor: Colors.blue.shade100,
                          elevation: 0,
                        ),
                        body: Center(
                          child: Text('${snapshot.error}'),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Scaffold(
                        backgroundColor: Colors.blue.shade100,
                        appBar: AppBar(
                          title: Text("Account Form",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                          iconTheme: IconThemeData(color: Colors.black54),
                          backgroundColor: Colors.blue.shade100,
                          elevation: 0,
                        ),
                        body: Container(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formkey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.person_outline),
                                        Expanded(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                              validator: RequiredValidator(
                                                  errorText:
                                                      'Please enter your username'),
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                label: Text(" Username"),
                                                border: InputBorder.none,
                                              ),
                                              onSaved: (String? username) {
                                                myInfo.username = username!;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.person_pin_outlined),
                                        Expanded(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                              validator: RequiredValidator(
                                                  errorText:
                                                      'Please enter your firstname'),
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                label: Text(" Firstname"),
                                                border: InputBorder.none,
                                              ),
                                              onSaved: (String? fname) {
                                                myInfo.fname = fname!;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.person_pin_outlined),
                                        Expanded(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                              validator: RequiredValidator(
                                                  errorText:
                                                      'Please enter your lastname'),
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                label: Text(" Lastname"),
                                                border: InputBorder.none,
                                              ),
                                              onSaved: (String? lname) {
                                                myInfo.lname = lname!;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.person_pin_outlined),
                                        Expanded(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                              validator: RequiredValidator(
                                                  errorText:
                                                      'Please enter your nickname'),
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                label: Text(" Nickname"),
                                                border: InputBorder.none,
                                              ),
                                              onSaved: (String? nickname) {
                                                myInfo.nickname = nickname!;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    padding: const EdgeInsets.only(left: 10),
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.calendar_today),
                                        Expanded(
                                          child: TextButton(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                myInfo.dob = (getText()),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                            onPressed: () {
                                              pickDate(context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /*Container(
                          width: double.infinity,
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF2C72CE),
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                            ),
                            child: Text(myInfo.dob = (getText()),style: TextStyle(fontSize: 20.0, color: Colors.white),),
                            onPressed: () {
                              pickDate(context);
                            },
                          ),
                        ),*/
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    padding: const EdgeInsets.only(left: 10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.call),
                                        Expanded(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: TextFormField(
                                              validator: RequiredValidator(
                                                  errorText:
                                                      'Please enter your phone number'),
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                label: Text(" Phone Number"),
                                                border: InputBorder.none,
                                              ),
                                              onSaved: (String? phone) {
                                                myInfo.phone = phone!;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF2C72CE),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 10),
                                      ),
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          formkey.currentState!.save();
                                          _myCollection
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid)
                                              .set({
                                            'username': myInfo.username,
                                            'fname': myInfo.fname,
                                            'lname': myInfo.lname,
                                            'nickname': myInfo.nickname,
                                            'dob': myInfo.dob,
                                            'phone': myInfo.phone,
                                            'profile url': myInfo.picUrl
                                          });
                                                            formkey.currentState!.reset();
                                          Fluttertoast.showToast(
                                              msg:
                                                  'User account has been created',
                                              gravity: ToastGravity.CENTER);
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return LoginDemo();
                                          }));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  })
              : NoInternet();
        }
        return Container(
          child: Center(
            child: NoInternet(),
          ),
        );
      },
    );
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime.now());
    if (newDate == null) return;

    setState(() {
      myDate = newDate;
    });
  }
}
