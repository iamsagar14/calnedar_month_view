import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
class DayCalendar extends StatefulWidget {
  const DayCalendar({Key? key}) : super(key: key);

  @override
  State<DayCalendar> createState() => _DayCalendarState();
}

class _DayCalendarState extends State<DayCalendar> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Day View '),),
        body:  DayView(

          controller: EventController(),
          eventTileBuilder: (date, events, boundry, start, end) {
            // Return your widget to display as event tile.
            return Container();
          },
          fullDayEventBuilder: (events, date) {
            // Return your widget to display full day event view.
            return Container(
              height: 200,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10)
              ),
            );
          },

          showVerticalLine: true, // To display live time line in day view.
          showLiveTimeLineInAllDays: true, // To display live time line in all pages in day view.
          minDay: DateTime(1990),
          maxDay: DateTime(2050),
          initialDay: DateTime(2023, 1, 1),
          heightPerMinute: 2.5, // height occupied by 1 minute time span.
          eventArranger: SideEventArranger(), // To define how simultaneous events will be arranged.
          onEventTap: (events, date) => print(events),
          onDateLongPress: (date) => print(date),
        ),
      ),
    );
  }
}
