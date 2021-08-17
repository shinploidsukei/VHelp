import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendar"),
        ),
        body: SfCalendar(
          view: CalendarView.week,
          dataSource: MeetingDataSource(getAppointments()),
        ));
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime StartTime = DateTime(today.year, today.month, today.day,
      today.hour, today.minute, today.second);
  final DateTime endTime = StartTime.add(const Duration(hours: 1));

  /*meetings.add(Appointment(
      startTime: StartTime,
      endTime: endTime,
      subject: 'Conference',
      color: Colors.blue));
  // recurrenceRule: 'FREQ=DAILY;COUNT=10'))
  // isAllDay: true));
*/
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
