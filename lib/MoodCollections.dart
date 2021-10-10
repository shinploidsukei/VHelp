import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'connectivity_provider.dart';
import 'DiaryLog.dart';
import 'DiarytDetail.dart';

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
  Widget _showingSelected(int index){
  return Container(

  );
  }
}

