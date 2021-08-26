import 'package:vhelp_test/date_picker_widget.dart';
import 'package:vhelp_test/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'content.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin notificationsPlugin =
FlutterLocalNotificationsPlugin();

class DocNoti extends StatelessWidget {
  static final String title = 'Date (Range) & Time';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      primaryColor: Colors.black,
    ),
    home: DocNotiPage(),
  );
}

class DocNotiPage extends StatefulWidget {
  @override
  DocNotiPageState createState() => DocNotiPageState();
}

class DocNotiPageState extends State<DocNotiPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: buildPages(),
  );


  Widget buildPages() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Notification"),
        backgroundColor: Colors.blueGrey,
        elevation: 4.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
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
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.blue.shade100],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            DatePickerWidget(),
            const SizedBox(height: 24),
            TimePickerWidget(),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
            ),
            Text(
                'Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold )
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.add_location),
                border: OutlineInputBorder(),
                hintText: 'Bangkok Hospital',
                fillColor: Colors.black26,
                hoverColor: Colors.grey,
                filled: true,
                hintStyle: TextStyle(color: Colors.black26),
                contentPadding: EdgeInsets.all(8),
              ),
            ),
            SizedBox(
                height: 100
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.lightGreen, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {

                },
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.deepOrange, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {

                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }

}

/*Future<void> displayNotification(String match, DateTime dateTime) async {
  notificationsPlugin.zonedSchedule(
      0,
      match,
      'Match is Started',
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id', 'channel name', 'channel description'),
      ),
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true);
}*/

