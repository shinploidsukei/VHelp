import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vhelp_test/page/event_editing_page.dart';
import 'package:vhelp_test/widget/calendar_widget.dart';

class DocNoti extends StatefulWidget {
  @override
  _DocNotiPage createState() => _DocNotiPage();
}


class _DocNotiPage extends State<DocNoti> {
@override 

Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Doctor Notification'),
          centerTitle: true,
        ),
        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.red,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventEditingPage()),
          ),
        ),
      );
}