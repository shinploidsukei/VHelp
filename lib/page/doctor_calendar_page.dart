import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vhelp_test/utils/notification_services.dart';

class DoctorCalendar extends StatefulWidget {
  const DoctorCalendar({Key? key}) : super(key: key);

  @override
  _DoctorCalendarState createState() => _DoctorCalendarState();
}

class _DoctorCalendarState extends State<DoctorCalendar> {
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMd().format(DateTime.now())),
                    Text('Today')
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
