import 'dart:math';
import 'package:provider/provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhelp_test/Content.dart';
import 'package:vhelp_test/MedConfirmSuccess.dart';
import 'package:vhelp_test/model/userDate.dart';
import '/notification_api.dart';
import 'package:vhelp_test/notification_api.dart';

import 'connectivity_provider.dart';

class MedNoti extends StatefulWidget {
  @override
  _MedNoti createState() => _MedNoti();
}

class _MedNoti extends State<MedNoti> {
  static final String title = 'Local Notifications';
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
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
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: title,
                  theme: ThemeData(primarySwatch: Colors.blueGrey),
                  home: MedNotiPage(),
                )
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
}

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
  TextEditingController controller = TextEditingController();

  DateTime? medNotiDate;
  TimeOfDay? medNotiTime;
  userDate iDate = userDate(medDate: '', medTime: '', notiWord: '');

  String getTextDate() {
    // ignore: unnecessary_null_comparison
    if (medNotiDate == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(medNotiDate!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  String getTextTime() {
    // ignore: unnecessary_null_comparison
    if (medNotiTime == null) {
      return 'Select Time';
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
        appBar: AppBar(
          title: Text("Medicine Notification"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          elevation: 4.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            hoverColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  scale: 5,
                  image: AssetImage('assets/images/cut.png'),
                  alignment: Alignment.bottomCenter),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.blue.shade200])),
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Date',
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
                child: Text('Time',
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
                child: Text('Notification Word',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'playing football',
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
                title: 'Confirm',
                icon: Icons.notifications_active,
                onClicked: () {
                  print(medNotiDate.toString() + medNotiTime.toString());
                  // print(medNotiDate!.setTimeOfDay(time));
                  NotificationApi.showScheduledNotification(
                    title: 'VHelp',
                    body: '${iDate.notiWord}',
                    payload:
                        'Date: ${iDate.medDate} \nTime: ${iDate.medTime} \nNotification Word: \n ${iDate.notiWord}',
                    scheduledDate: DateTime.now().add(Duration(
                        days: medNotiDate!.day - DateTime.now().day,
                        hours: medNotiTime!.hour - DateTime.now().hour,
                        minutes: medNotiTime!.minute - DateTime.now().minute)),
                  );

                  final snackBar = SnackBar(
                    content: Text(
                      'Scheduled in ${(medNotiDate!.difference(DateTime.now()).inDays)} day, ${((medNotiDate!.difference(DateTime.now()).inHours) - 24 * medNotiDate!.difference(DateTime.now()).inDays)} hours, ${(medNotiDate!.difference(DateTime.now()).inMinutes).abs() - 60 * (DateTime.now().difference(medNotiDate!).inHours)} minutes',
                      style: TextStyle(fontSize: 24),
                    ),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(snackBar);
                },
              ),
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
                  label: Text('Confirm', style: TextStyle(fontSize: 20)),
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
      firstDate: DateTime(DateTime.now().year - 5),
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
            'Random Words',
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
      'กินข้าว',
      'ดูหนัง',
      'เตะบอล',
      'ไปซื้อชานมไข่มุก',
      'สั่งเซเว่น',
      'โทรหาแม่ด้วย',
      'อย่าลืมซักผ้า',
      'กินชาบู'
    ];
    final random = new Random();
    String item = list[random.nextInt(list.length)];
    return item;
  }
}
