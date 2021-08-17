import 'package:vhelp_test/Calendar.dart';

import 'button_widget.dart';
import 'date_picker_widget.dart';
import 'date_range_picker_widget.dart';
import 'datetime_picker_widget.dart';
import 'time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import "dart:math";

class MedNoti extends StatelessWidget {
  static final String title = 'Date (Range) & Time';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: MedNotiPage(),
      );
}

class MedNotiPage extends StatefulWidget {
  @override
  _MedNotiPageState createState() => _MedNotiPageState();
}

class _MedNotiPageState extends State<MedNotiPage> {
  int index = 0;
  Object? arguments;
  final controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //final ValueChanged<String> onChanged;
  //const Buttons({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      //bottomNavigationBar: buildBottomBar(),
      appBar: AppBar(
        title: Text("Medicine Notification"),
        backgroundColor: Colors.blueGrey,
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
            hoverColor: Colors.white,
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => Calendar())),
          ),
        ],
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: Stack(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/cut.png'),
                  alignment: Alignment.bottomCenter),
              gradient: LinearGradient(
                  colors: [Colors.blue.shade200, Colors.blueGrey],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DatePickerWidget(),
              const SizedBox(height: 24),
              TimePickerWidget(),
              const SizedBox(height: 24),
              Text('Notification Word',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'playing football',
                    hintStyle: TextStyle(color: Colors.black26),
                    contentPadding: EdgeInsets.all(8)),
                controller: controller,
              ),
              const SizedBox(height: 24),
              buildRandomButton(),
              SizedBox(
                height: 80,
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text('Dummy'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Calendar())),
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]));

  Widget buildRandomButton() {
    final backgroundColor = MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.pressed)
            ? Colors.blueGrey
            : Colors.black38);

    return TextButton.icon(
      style: ButtonStyle(backgroundColor: backgroundColor),
      label: Text('Random Words'),
      icon: Icon(Icons.autorenew, color: Colors.white),
      onPressed: () {
        final rWords = getRandomItem();
        controller.text = rWords;
      },
    );
  }

  String getRandomItem() {
    List<String> list = [
      'กินข้าว',
      'ดูหนัง',
      'เตะบอล',
      'ไปซื้อชานมไข่มุก',
      'สั่งเซเว่น',
      'โทรหาแม่ด้วย',
      'อย่าลืมซักผ้า'
    ];
    final random = new Random();
    String item = list[random.nextInt(list.length)];
    //print(item);
    return item;
    //return Text("$item");
  }
}
