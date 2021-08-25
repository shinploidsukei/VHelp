import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import '../Login.dart';
import '../model/userInfo.dart';

class profileForm extends StatefulWidget {
  const profileForm({Key? key}) : super(key: key);

  @override
  _profileFormState createState() => _profileFormState();
}

class _profileFormState extends State<profileForm> {
  final formkey = GlobalKey<FormState>();
  userInfo myInfo = userInfo(
      username: '', fname: '', lname: '', nickname: '', dob: '', phone: '');

  DateTime? myDate;
  String getText() {
    // ignore: unnecessary_null_comparison
    if (myDate == null) {
      return 'Select Date';
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
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title:
                    Text("Account Form", style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blue.shade200,
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Please enter your username'),
                          onSaved: (String? username) {
                            myInfo.username = username!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Firstname',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Please enter your firstname'),
                          onSaved: (String? fname) {
                            myInfo.fname = fname!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Lastname',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Please enter your lastname'),
                          onSaved: (String? lname) {
                            myInfo.lname = lname!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Nickname',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Please enter your nickname'),
                          onSaved: (String? nickname) {
                            myInfo.nickname = nickname!;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Date of Birth',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(myInfo.dob = (getText())),
                            onPressed: () {
                              pickDate(context);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Please enter your phone number'),
                          onSaved: (String? phone) {
                            myInfo.phone = phone!;
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                _myCollection.add({
                                  'username': myInfo.username,
                                  'fname': myInfo.fname,
                                  'lname': myInfo.lname,
                                  'nickname': myInfo.nickname,
                                  'dob': myInfo.dob,
                                  'phone': myInfo.phone
                                });
                                formkey.currentState!.reset();
                                Fluttertoast.showToast(
                                    msg: 'User account has been created',
                                    gravity: ToastGravity.CENTER);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
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
        });
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
