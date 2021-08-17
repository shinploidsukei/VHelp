import 'package:flutter/material.dart';
//import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:vhelp_test/DiaryCard.dart';
import 'package:vhelp_test/YearPixels.dart';
import 'package:vhelp_test/page/notes_page.dart';
import 'content.dart';

class DiaryLogPage extends StatefulWidget {
  const DiaryLogPage({Key? key}) : super(key: key);

  @override
  _DiaryLogPageState createState() => _DiaryLogPageState();
}

class _DiaryLogPageState extends State<DiaryLogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              itemCount: 7,
              itemBuilder: (context, index) {
                return DiaryCard(day: index);
              },
            ),
          ),
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
                        icon: Icon(Icons.create, color: Colors.white),
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
                        icon: Icon(Icons.table_rows, color: Colors.white),
                        onPressed: () {})),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                    height: 60,
                    child: IconButton(
                        //style: ButtonStyle(backgroundColor: Colors.blueGrey),
                        //label: Text('New Page'),
                        icon: Icon(Icons.pending_actions, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YearPixels()),
                          );
                        })),
              ),
            ],
          )
        ],
      )),
    );
  }
}
