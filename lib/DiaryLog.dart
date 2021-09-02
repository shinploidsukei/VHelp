import 'package:flutter/material.dart';
import 'package:vhelp_test/model/colorLog.dart';
import 'DiaryCard.dart';
import 'YearPixels.dart';
import 'page/notes_page.dart';
import 'content.dart';

class DiaryLogPage extends StatefulWidget {
  const DiaryLogPage({Key? key}) : super(key: key);

  @override
  _DiaryLogPageState createState() => _DiaryLogPageState();
}

class _DiaryLogPageState extends State<DiaryLogPage> {
  //test database on this
  colorLog colorSaved = colorLog(colorSaved: null);

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
                // try on this
                return DiaryCard(day: colorSaved.colorSaved = index);
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

  double getColorIndex(int index) {
    switch (index % 7) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      case 4:
        return 100;
      case 5:
        return 100;
      case 6:
        return 100;
      default:
        return 100;
    }
  }
}
