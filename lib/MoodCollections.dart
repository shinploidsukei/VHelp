import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'DiaryCard.dart';
import 'YearPixels.dart';
import 'connectivity_provider.dart';
import 'page/notes_page.dart';
import 'DiaryLog.dart';

class MoodCollectionsPage extends StatefulWidget {
  const MoodCollectionsPage({Key? key}) : super(key: key);

  @override
  _MoodCollectionsPageState createState() => _MoodCollectionsPageState();
}

class _MoodCollectionsPageState extends State<MoodCollectionsPage> {
  //test database on this

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline != null) {
          return model.isOnline
              ? Scaffold(
                  backgroundColor: Colors.blue.shade100,
                  appBar: AppBar(
                    title: Text("Mood Collections"),
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
                          MaterialPageRoute(builder: (context) => DiaryLogPage()),
                        );
                      },
                    ),
                  ),
                  body: Container(
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
