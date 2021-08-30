import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vhelp_test/event.dart';

class EventDataSource extends CalendarDataSource{
  EventDataSource(List<Event> appointments){
    this.appointments = appointments;
  }
  Event getEvent( int index) => appointments![index]as Event;
  @override
 DateTime getStartTime(int index) {
   return appointments![index].from;
 }

 @override
 DateTime getEndTime(int index) {
   return appointments![index].to;
 }

 @override
 String getSubject(int index) {
   return appointments![index].title;
 }

 @override
 Color getColor(int index) => getEvent(index).backgroundcolor;

 @override
 bool isAllDay(int index) {
   return appointments![index].isAllDay;
 }

}
