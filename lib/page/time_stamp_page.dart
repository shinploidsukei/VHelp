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

class _TimestampPageState extends State<TimestampPage> {
  bool isLoading = false;
  late List<TimeStampDetails> times;

  @override
  void initState() {
    super.initState();
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
            MaterialPageRoute(
                builder: (context) => timeStamp()),
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
      );

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
