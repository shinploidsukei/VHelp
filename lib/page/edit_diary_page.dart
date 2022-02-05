import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/diary_page.dart';
import 'package:vhelp_test/widget/diary_form_widget.dart';

class AddEditMoodPage extends StatefulWidget {
  final colorLog? color;
  final String? colorID;

  const AddEditMoodPage({
    Key? key,
    this.color,
    this.colorID,
  }) : super(key: key);
  @override
  _AddEditMoodPageState createState() => _AddEditMoodPageState();
}

class _AddEditMoodPageState extends State<AddEditMoodPage> {
  final _formKey = GlobalKey<FormState>();
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
                                  builder: (context) => DiaryPage()),
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
                          child: Form(
                              key: _formKey,
                              child: checkIf(
                                  widget.color?.createTime, widget.colorID)),
                        ),
                      ),
                    );
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

  Widget checkIf(DateTime? today, String? todayL) {
    print('check today');
    print(today);
    print(todayL);

    final checkIfToday = DateFormat.yMMMd().format(DateTime.now());

    if (today != null) {
      final isToday = DateFormat.yMMMd().format(today);
      if (user?.isAnonymous == false) {
        if (todayL == checkIfToday) {
          return DiaryFormWidget(
            color: widget.color,
            colorIndex: colorIndex,
            onChangedColorIndex: (colorIndex) =>
                setState(() => this.colorIndex = colorIndex),
          );
        } else {
          return AddEditMoodPage(
            colorID: widget.colorID,
          );
        }
      } else {
        if (isToday == checkIfToday) {
          return DiaryFormWidget(
            color: widget.color,
            colorIndex: colorIndex,
            onChangedColorIndex: (colorIndex) =>
                setState(() => this.colorIndex = colorIndex),
          );
        } else {
          return AddEditMoodPage(
            color: widget.color,
          );
        }
      }
    } else {
      if (user?.isAnonymous == false) {
        return DiaryFormWidget(
          color: widget.color,
          colorIndex: colorIndex,
          onChangedColorIndex: (colorIndex) =>
              setState(() => this.colorIndex = colorIndex),
        );
      } else {
        return DiaryFormWidget(
          color: widget.color,
          colorIndex: colorIndex,
          onChangedColorIndex: (colorIndex) =>
              setState(() => this.colorIndex = colorIndex),
        );
      }
    }
  }
}
