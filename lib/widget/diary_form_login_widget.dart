import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/PopupDialogLogIn.dart';
import 'package:vhelp_test/model/colorLog.dart';
import '../connectivity_provider.dart';
import '../no_internet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryFormLogInWidget extends StatefulWidget {
  final colorLog? color;
  final String? colorID;

  const DiaryFormLogInWidget(
      {Key? key,
      required int colorIndex,
      this.color,
      this.colorID,
      required void Function(int) onChangedColorIndex})
      : super(key: key);

  @override
  _DiaryFormLogInWidgetState createState() => _DiaryFormLogInWidgetState();
}

class _DiaryFormLogInWidgetState extends State<DiaryFormLogInWidget> {
  int? selectedIndex;
  late int thisColor;

  String now = DateFormat("dd-MM-yyyy").format(DateTime.now());

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference _moodDB =
      FirebaseFirestore.instance.collection('Accounts');

  var emojiColors = [
    Colors.red[200],
    Colors.orange[200],
    Colors.yellow[200],
    Colors.green[200],
    Colors.green[400],
  ];

  @override
  void initState() {
    super.initState();

    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
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
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Container(
                            child: Container(
                                child: Text(
                              S.of(context)!.today2 + " $now",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ...List.generate(
                                    5, (index) => _buildEmoji(index)),
                              ],
                            )),
                          ),
                          SizedBox(height: 10),
                        ],
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
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildEmoji(int index) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.emoji_emotions),
        color: selectedIndex == index ? Colors.black : emojiColors[index],
        iconSize: 40.0,
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) => PopupDialogLogIn(
              selectedIndex: index,
              emojiColor: emojiColors[index]!,
            ),
          );
          setState(() {
            selectedIndex = index;
            thisColor = index;
            addOrUpdateColor(index);
          });
        },
      ),
    );
  }

  void addOrUpdateColor(int index) async {
    final itHas = widget.colorID != null;
    print('check add or edit');
    print(widget.colorID);
    print(itHas);

    if (itHas) {
      await updateColorLI();
    } else {
      await addColorLI();
      print(itHas);
    }
  }

  Future updateColorLI() async {
    final color = colorLog(
      colorSaved: thisColor,
      createTime: DateTime.now(),
    );

    DocumentReference ref = _moodDB.doc(FirebaseAuth.instance.currentUser?.uid);
    CollectionReference ref2 = ref.collection('Moods');

    print('widget id');
    print(widget.colorID);

    await ref2.doc(widget.colorID).update({
      'colorSaved': color.colorSaved,
    });
  }

  Future addColorLI() async {
    final color = colorLog(
      colorSaved: thisColor,
      createTime: DateTime.now(),
    );

    DocumentReference ref = _moodDB.doc(FirebaseAuth.instance.currentUser!.uid);
    CollectionReference ref2 = ref.collection('Moods');

    final String time = DateFormat.yMMMd().format(DateTime.now());
    final String timeDay = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String timeHour = DateFormat('HH:mm').format(DateTime.now());
    final String timeForNote =
        DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.now());
    await ref2.doc(time).set({
      'colorSaved': color.colorSaved,
      'datetime': timeForNote,
      'dateID': time,
      'dateHour': timeHour,
      'dateDay': timeDay,
    });
  }
}
