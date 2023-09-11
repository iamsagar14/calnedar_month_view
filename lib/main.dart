// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:calendar_view/calendar_view.dart';
import 'package:calendarapp/day_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'adding_events.dart';
import 'home_screen.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller:  EventController(),
      child: MaterialApp(
        title: 'TableCalendar Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DayCalendar(),
      ),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfCalendar(
            view: CalendarView.month,
            dataSource: MeetingDataSource(_getDataSource()),
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.none,
                dayFormat: 'EEE',
                numberOfWeeksInView: 6,
                monthCellStyle: MonthCellStyle(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                    trailingDatesTextStyle:
                        TextStyle(color: Colors.grey, fontSize: 10))),
            headerStyle: CalendarHeaderStyle(
              textAlign: TextAlign.center,
            ),
            showNavigationArrow: true,
            blackoutDates: [
              DateTime.now()
            ],
            monthCellBuilder: (context, details) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: details.date.weekday != 7 ? BorderSide(color: Colors.grey.withOpacity(0.2)): BorderSide.none,
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.2))
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 44,
                        width: 44,
                        // margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: details.date.weekday == 6
                                ? Color(0xFFF5D7D7)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            details.date.day.toString(),
                          ),
                        )),
                    details.appointments.length != 0
                        ? Container(
                            height: 16,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                color:const Color(0xFFD4EEF8),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Center(
                              child: Text(
                                "${details.appointments.length} sessions",
                                style: const TextStyle(fontSize: 8),
                              ),
                            ),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ));
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];

    final DateTime today = DateTime.now();

    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('session', startTime, endTime, const Color(0xFFD4EEF8),
        false, 'FREQ=WEEKLY;BYDAY=MO,WE,FR;INTERVAL=1;COUNT=10'));

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

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
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getRecurrenceRule(int index) {
    return appointments![index].recurrenceRule;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.recurrenceRule);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String? recurrenceRule;
}

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SfCalendar(
//           cellBorderColor: Colors.grey.withOpacity(0.5),
//
//           showNavigationArrow: true,
//           // cellEndPadding: 20,
//           todayHighlightColor: Color(0xFF29A9DB),
//           backgroundColor: Colors.grey.withOpacity(0.1),
//           view: CalendarView.month,
//         initialDisplayDate: DateTime(2023,8,24),
//           selectionDecoration: BoxDecoration(
//             color: Color(0XFFF5D7D7),
//             // border: Border.all(color: Colors.blue, width: 2),
//             borderRadius: const BorderRadius.all(Radius.circular(8)),
//             shape: BoxShape.rectangle,
//           ),
//           dataSource: MeetingDataSource(_getDataSource()),
//           monthViewSettings: MonthViewSettings(
//               appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
//         ),
//       ),
//     );
//
//   }
// }
// List<Meeting> _getDataSource() {
//   final List<Meeting> meetings = <Meeting>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//   DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));
//   meetings.add(Meeting(
//       '5sessions', startTime, endTime, const Color(0xFFD4EEF8), true));
//   meetings.add(Meeting(
//       'sagar', startTime.subtract(Duration(hours: 0)), endTime, const Color(0xFFD4EEF8), false));
//   return meetings;
// }
//
//
// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
// }
//
// class Meeting {
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;
// }
// _AppointmentDataSource _getCalendarDataSource() {
//   List<Appointment> appointments = <Appointment>[];
//
//   appointments.add(Appointment(
//       startTime: DateTime(2023,8,29),
//       endTime: DateTime(2023,8,30),
//       subject: 'Meeting',
//       color: Colors.blue,
//       recurrenceRule: 'FREQ=DAILY;INTERVAL=2;COUNT=10'));
//
//   return _AppointmentDataSource(appointments);
// }
//
// class _AppointmentDataSource extends CalendarDataSource {
//   _AppointmentDataSource(List<Appointment> source) {
//     appointments = source;
//   }
// }
