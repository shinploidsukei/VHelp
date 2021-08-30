import 'package:provider/provider.dart';
import 'package:vhelp_test/date_picker_widget.dart';
import 'package:vhelp_test/page/event_editing_page.dart';
import 'package:vhelp_test/provider/event_provider.dart';
import 'package:vhelp_test/time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:vhelp_test/widget/calendar_widget.dart';
import 'content.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin notificationsPlugin =
FlutterLocalNotificationsPlugin();

class DocNoti extends StatelessWidget {
  static final String title = 'Date (Range) & Time';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(create:(context)=> EventProvider(), 
  
  child:MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      primaryColor: Colors.blueGrey,
    ),
    home: DocNotiPage(),
   ) );
}

class DocNotiPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Doctor Notification'),
      centerTitle: true,
    ),
    body: CalendarWidget(),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add,color: Colors.white),
      backgroundColor: Colors.blue.shade200,
      onPressed: ()=> Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EventEditingPage()),
      ),
    ),
  );
}
