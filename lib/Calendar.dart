import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vhelp_test/connectivity_provider.dart';
import 'package:vhelp_test/no_internet.dart';
import 'package:vhelp_test/widget/language_picker_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return pageUI();
  }

  Widget pageUI(){
     return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline) {
          return model.isOnline
              ?  Scaffold(
        appBar: AppBar(
          title: Text(S.of(context)!.sidebar5,),
          actions: [
            LanguagePickerWidget(),
            //const SizedBox(width: 12),
          ],
        ),
        body: SfCalendar(
          view: CalendarView.week,
          dataSource: MeetingDataSource(getAppointments()),
        )): NoInternet();
  }
     return Container(
          child: Center(
            child: NoInternet(),
          ),
        );
      },
    );
  } 
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  // ignore: non_constant_identifier_names
  final DateTime StartTime = DateTime(today.year, today.month, today.day,
      today.hour, today.minute, today.second);
  // ignore: unused_local_variable
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
