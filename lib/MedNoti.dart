import 'package:intl/intl.dart';
import '../model/userDate.dart';
import 'drawer_sidebar.dart';
import 'package:flutter/material.dart';
import "dart:math";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '/drawer_sidebar.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> Notification() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

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
  late Object arguments;
  TextEditingController controller = TextEditingController();

  DateTime? medNotiDate;
  TimeOfDay? medNotiTime;
  userDate iDate = userDate(medDate: '', medTime: '', notiWord: '');

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('nextflow_noti_001', 'Medicine Notification',
            'Take medicine please',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
  }

  String getTextDate() {
    // ignore: unnecessary_null_comparison
    if (medNotiDate == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(medNotiDate!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  String getTextTime() {
    // ignore: unnecessary_null_comparison
    if (medNotiTime == null) {
      return 'Select Time';
    } else {
      final hours = medNotiTime!.hour.toString().padLeft(2, '0');
      final minutes = medNotiTime!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //final ValueChanged<String> onChanged;
  //const Buttons({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      //bottomNavigationBar: buildBottomBar(),
      decoration: BoxDecoration(
          image: DecorationImage(
              scale: 5,
              image: AssetImage('assets/images/cut.png'),
              alignment: Alignment.bottomCenter),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade300, Colors.blueGrey.shade700])),


      child: Scaffold(
       appBar: AppBar(
        title: Text("Medicine Notification"),
        backgroundColor: Colors.transparent,
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
            hoverColor: Colors.white,
            onPressed: () {},
          )
        ],
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: 
        Container(
          padding: const EdgeInsets.all(30.0),
          
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text('Date',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black12),
                        //padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 18))),
                    child: Text(iDate.medDate = (getTextDate())),
                    onPressed: () {
                      pickDate(context);
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                
                Text('Time',

                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
               const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                     style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black12),
                        //padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 18))),
                    child: Text(iDate.medTime = (getTextTime())),
                    onPressed: () {
                      pickTime(context);
                    },
                  ),
                ),
                
                const SizedBox(height: 24),
                Text('Notification Word',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                  onChanged: (String? noti) {
                    noti = controller.text;
                    iDate.notiWord = noti;
                  },
                ),
                const SizedBox(height: 24),
                buildRandomButton(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightGreen)),
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Confirmation'),
                                content: Text(
                                    'Date: ${iDate.medDate} \nTime: ${iDate.medTime} \nNotification Word: ${iDate.notiWord}'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _showNotification();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    },
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
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepOrange)),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return NavigationDrawerWidget();
                          },
                        ));
                      }),
                ),
              ],
            ),
          ),
        ),
      ));

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
        iDate.notiWord = rWords;
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
    return item;
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => medNotiDate = newDate);
  }

  Future pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime == null) return;

    setState(() => medNotiTime = newTime);
  }
}