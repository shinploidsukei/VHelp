import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/diary_login_page.dart';
import 'package:vhelp_test/widget/diary_form_login_widget.dart';

class AddEditMoodLogInPage extends StatefulWidget {
  final colorLog? color;
  final String? colorID;
  //final DateTime? checkIfToday;

  const AddEditMoodLogInPage({
    Key? key,
    this.color,
    this.colorID,
    //this.checkIfToday,
  }) : super(key: key);
  @override
  _AddEditMoodLogInPageState createState() => _AddEditMoodLogInPageState();
}

class _AddEditMoodLogInPageState extends State<AddEditMoodLogInPage> {
  late bool isImportant;

  late int colorIndex;

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    colorIndex = widget.color?.colorSaved ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline) {
        return model.isOnline
            ? FutureBuilder(
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
                        backgroundColor: Colors.blue[100],
                        appBar: AppBar(
                          leading: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DiaryLogInPage()),
                              );
                            },
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          iconTheme: IconThemeData(color: Colors.black54),
                          backgroundColor: Colors.blue.shade100,
                          elevation: 0,
                        ),
                        body: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Form(child: checkIf(widget.colorID)),
                          ),
                        ));
                  }
                  return Container(
                    child: Center(
                      child: NoInternet(),
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
    });
  }

  Widget checkIf(String? todayL) {
    print('check today');
    print(todayL);

    final checkIfToday = DateFormat.yMMMd().format(DateTime.now());

    //DocumentReference ref = _moodDB.doc(FirebaseAuth.instance.currentUser?.uid);
    //CollectionReference ref2 = ref.collection('Moods');

    if (todayL != null) {
      print('test change color from previous day');
      return DiaryFormLogInWidget(
          colorID: widget.colorID,
          colorIndex: colorIndex,
          onChangedColorIndex: (colorIndex) =>
              setState(() => this.colorIndex = colorIndex));
    } else if (todayL == checkIfToday) {
      print('test 2///////////2222222222222222');
      return DiaryFormLogInWidget(
        color: widget.color,
        colorIndex: colorIndex,
        onChangedColorIndex: (colorIndex) =>
            setState(() => this.colorIndex = colorIndex),
      );
    } else {
      print('test 3///////////333333333333333333');
      return DiaryFormLogInWidget(
        color: widget.color,
        colorIndex: colorIndex,
        onChangedColorIndex: (colorIndex) =>
            setState(() => this.colorIndex = colorIndex),
      );
    }
  }
}
