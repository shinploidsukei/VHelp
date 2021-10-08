import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'package:vhelp_test/no_internet.dart';
import 'DiaryCard.dart';
import 'MoodCollections.dart';
import 'connectivity_provider.dart';
import 'page/notes_page.dart';
import 'content.dart';

class DiaryLogPage extends StatefulWidget {
  const DiaryLogPage({Key? key}) : super(key: key);

  @override
  _DiaryLogPageState createState() => _DiaryLogPageState();
}

class _DiaryLogPageState extends State<DiaryLogPage> {

  //test database on this

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
        if (model.isOnline != null) {
          return model.isOnline
              ? Scaffold(
                  backgroundColor: Colors.blue.shade100,
                  appBar: AppBar(
                    title: Text("Diary Log"),
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
                      child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return DiaryCard(
                              day: index,
                            );
                          },
                        ),
                      ),
                      // bottom bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: SizedBox(
                                height: 60,
                                child: IconButton(
                                    //style: ButtonStyle(backgroundColor: Colors.blueGrey),
                                    //label: Text('New Page'),
                                    icon:
                                        Icon(Icons.create, color: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NotesPage()),
                                      );
                                    })),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: SizedBox(
                                height: 60,
                                child: IconButton(
                                    //style: ButtonStyle(backgroundColor: Colors.blueGrey),
                                    //label: Text('New Page'),
                                    icon: Icon(Icons.table_rows,
                                        color: Colors.white),
                                    onPressed: () {})),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: SizedBox(
                                height: 60,
                                child: IconButton(
                                    //style: ButtonStyle(backgroundColor: Colors.blueGrey),
                                    //label: Text('New Page'),
                                    icon: Icon(Icons.pending_actions,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MoodCollectionsPage()),
                                      );
                                    })),
                          ),
                        ],
                      )
                    ],
                  )),
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

