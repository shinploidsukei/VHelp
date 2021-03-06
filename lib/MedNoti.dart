// ignore_for_file: unrelated_type_equality_checks

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/MedConfirmSuccess.dart';
import 'package:vhelp_test/model/userDate.dart';
import '/notification_api.dart';
import 'package:vhelp_test/notification_api.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MedNotiPage extends StatefulWidget {
  @override
  _MedNotiPageState createState() => _MedNotiPageState();
}

class _MedNotiPageState extends State<MedNotiPage> {
  @override
  void initState() {
    super.initState();

    NotificationApi.init(initScheduled: true);
    listenNotifications();

    /// Optionally schedule notification on app start
    // NotificationApi.showScheduledNotification(
    //   title: 'Dinner',
    //   body: 'Today at 6 PM',
    //   payload: 'dinner_6pm',
    //   scheduledDate: DateTime.now().add(Duration(seconds: 12)),
    // );
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MedConfirmSuccess(payload: payload),
      ));

  /// Alternativaly showDialog instead of navigation
  /* showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payload'),
          content: Text(payload ?? ''),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            )
          ],
        ),
      ); */

  int index = 0;
  late Object arguments;
  TextEditingController controller = TextEditingController(text: '');

  DateTime? medNotiDate;
  TimeOfDay? medNotiTime;
  userDate iDate = userDate(medDate: '', medTime: '', notiWord: '');

  String getTextDate() {
    // ignore: unnecessary_null_comparison
    if (medNotiDate == null) {
      return S.of(context)!.select_date;
    } else {
      return DateFormat('dd/MM/yyyy').format(medNotiDate!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  String getTextTime() {
    // ignore: unnecessary_null_comparison
    if (medNotiTime == null) {
      return S.of(context)!.select_time;
    } else {
      final hours = medNotiTime!.hour.toString().padLeft(2, '0');
      final minutes = medNotiTime!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          iconTheme: IconThemeData(color: Colors.black54),
          backgroundColor: Colors.blue.shade100,
          elevation: 0,
          actions: [
            LanguagePickerWidget(),
            //const SizedBox(width: 12),
          ],
          title: Text(S.of(context)!.sidebar3,
              style: TextStyle(color: Colors.black54, fontSize: 22)),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                scale: 5,
                image: AssetImage('assets/images/cut.png'),
                alignment: Alignment.bottomCenter),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.topLeft,
                child: Text(S.of(context)!.date,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black12),
                      //padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 18))),
                  child: Text(iDate.medDate = (getTextDate())),
                  onPressed: () {
                    pickDate(context);
                  },
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.topLeft,
                child: Text(S.of(context)!.time,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black12),
                      //padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 18))),
                  child: Text(iDate.medTime = (getTextTime())),
                  onPressed: () {
                    pickTime(context);
                  },
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.topLeft,
                child: Text(S.of(context)!.notiword,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: S.of(context)!.mednoti_hinttext,
                    hintStyle: TextStyle(color: Colors.black26),
                    contentPadding: EdgeInsets.all(8)),
                controller: controller,
                onChanged: (String? noti) {
                  noti = controller.text;
                  iDate.notiWord = noti;
                },
              ),
              const SizedBox(height: 10),
              buildRandomButton(),
              SizedBox(
                height: 20,
              ),
              buildButton(
                  title: S.of(context)!.confirm,
                  icon: Icons.notifications_active,
                  onClicked: () {
                    print(medNotiDate.toString() + medNotiTime.toString());
                    // print(medNotiDate!.setTimeOfDay(time));
                    if (iDate.medDate.isEmpty ||
                        iDate.medTime.isEmpty ||
                        iDate.notiWord.isEmpty) {
                      final snackBar = SnackBar(
                        content: Text(
                          S.of(context)!.mednoti_warning,
                          style: TextStyle(fontSize: 24),
                        ),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } else {
                      NotificationApi.showScheduledNotification(
                        title: S.of(context)!.title_VHelp,
                        body: '${iDate.notiWord}',
                        payload:
                            'Date: ${iDate.medDate} \nTime: ${iDate.medTime} \nNotification Word: \n ${iDate.notiWord}',
                        scheduledDate: DateTime.now().add(Duration(
                            days: medNotiDate!.day - DateTime.now().day,
                            hours: medNotiTime!.hour - DateTime.now().hour,
                            minutes:
                                medNotiTime!.minute - DateTime.now().minute)),
                      );

                      final snackBar = SnackBar(
                        content: Text(
                          S.of(context)!.mednoti_success,
                          style: TextStyle(fontSize: 24),
                        ),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  }),
              Spacer(),
            ],
          ),
        ),
      );

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 60,
                width: 200,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 28.0,
                  ),
                  label: Text(S.of(context)!.confirm,
                      style: TextStyle(fontSize: 20)),
                  onPressed: onClicked,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ))
        ],
      );

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => medNotiDate = newDate);
  }

  Future pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime == null) return;

    setState(() => medNotiTime = newTime);
  }

  Widget buildRandomButton() {
    // ignore: unused_local_variable
    final backgroundColor = MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.pressed) ? Colors.white : Colors.black);

    return Align(
        alignment: Alignment.bottomLeft,
        child: TextButton.icon(
          //style: ButtonStyle(backgroundColor: backgroundColor),
          label: Text(
            S.of(context)!.random_words,
            style: TextStyle(color: Colors.black),
          ),
          icon: Icon(Icons.autorenew, color: Colors.black),
          onPressed: () {
            final rWords = getRandomItem();
            controller.text = rWords;
            iDate.notiWord = rWords;
          },
        ));
  }

  String getRandomItem() {
    List<String> list = [
      '?????????????????????',
      '??????????????????',
      '??????????????????',
      '????????????????????????????????????????????????',
      '??????????????????????????????',
      '????????????????????????????????????',
      '???????????????????????????????????????',
      '?????????????????????'
    ];
    final random = new Random();
    String item = list[random.nextInt(list.length)];
    return item;
  }
}
