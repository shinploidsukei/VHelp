import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vhelp_test/db/TimeStamp_database.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';
import 'package:vhelp_test/page/time_stamp.dart';
import 'package:vhelp_test/widget/timestamp_card_widget.dart';

class TimestampPage extends StatefulWidget {
  @override
  _TimestampPageState createState() => _TimestampPageState();
}

//var dbHelper = TimeStampLog;

class _TimestampPageState extends State<TimestampPage> {
  bool isLoading = false;
  late List<TimeStampDetails> times;
  int countID1 = -1;
  //late TimeStampDetails getCount;

  void countID() async {
    int? count = await TimeStampLog.instance.countID();
    setState(() => countID1 = count!);
  }

  @override
  void initState() {
    super.initState();
    countID();
    refreshNotes();
  }

  @override
  void dispose() {
    TimeStampLog.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.times = await TimeStampLog.instance.readAllLog();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => timeStamp()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          iconTheme: IconThemeData(color: Colors.black54),
          backgroundColor: Colors.blue.shade100,
          elevation: 0,
          title: Text('My Timestamp Log',
              style: TextStyle(color: Colors.black54, fontSize: 22)),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : times.isEmpty
                  ? Text(
                      'Add your Timestamp by clicking take medicine..',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    )
                  : buildNotes(),
        ),
        bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Total Logs: $countID1'),
          )
        ]),
      );

  /*Widget checkEvent() {
   // final isChecked = countID1 == 7 || countID1 == 14 || countID1 == 30; 
    if (countID1 == 7) {
      return AlertDialog(
        title: const Text('Challenge Mission'),
        content: const Text('Listen to the relaxing song!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
              child: const Text('Done'),
              onPressed: () => Navigator.pop(context, 'OK')),
        ],
      );
    } else if (countID1 == 14) {
      return AlertDialog(
        title: const Text('Challenge Mission'),
        content: const Text('Draw some pictures!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
              child: const Text('Done'),
              onPressed: () => Navigator.pop(context, 'OK')),
        ],
      );
    } else if (countID1 == 30) {
      return AlertDialog(
        title: const Text('Challenge Mission'),
        content: const Text('Watch relaxing movie!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
              child: const Text('Done'),
              onPressed: () => Navigator.pop(context, 'OK')),
        ],
      );
    } else 
     return AlertDialog(
        title: const Text('Good Jobs'),
        content: const Text('Keep Going'),
        actions: <Widget>[
          TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context, 'OK')),
        ],
      );
    
  }
  */

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: times.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(4),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final time = times[index];
          return timeStampWidget(timestamp: time);
        },
      );
}
