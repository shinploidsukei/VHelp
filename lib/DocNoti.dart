import 'package:flutter/material.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/page/event_editing_page.dart';
import 'package:vhelp_test/provider/event_provider.dart';
import 'package:vhelp_test/widget/calendar_widget.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/Content.dart';

class DocNoti extends StatefulWidget {
  @override
  _DocNoti createState() => _DocNoti();
}

class _DocNoti extends State<DocNoti> {
  static final String title = 'Calendar Events App';
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
              ? ChangeNotifierProvider(
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

class DocNotiPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.blue[100],
    appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()),
          );
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      iconTheme: IconThemeData(color: Colors.black54),
      backgroundColor: Colors.blue.shade200,
      elevation: 0,
      title: Text('Doctor Notification',
          style: TextStyle(color: Colors.black54, fontSize: 22)),
    ),
        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.blue.shade400,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventEditingPage()),
          ),
        ),
      );
}
