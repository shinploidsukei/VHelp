import 'package:flutter/material.dart';
import 'package:vhelp_test/page/event_editing_page.dart';
import 'package:vhelp_test/provider/event_provider.dart';
import 'package:vhelp_test/widget/calendar_widget.dart';
import 'package:provider/provider.dart';

class DocNoti extends StatelessWidget {
  static final String title = 'Calendar Events App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => EventProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          themeMode: ThemeMode.light,
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
            primaryColor: Colors.blueGrey,
          ),
          home: DocNotiPage(),
        ),
      );
}

class DocNotiPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Doctor Notification'),
          centerTitle: true,
        ),
        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.blue,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventEditingPage()),
          ),
        ),
      );
}
