import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  TextEditingController _eventController = TextEditingController();
  late Map<DateTime, List<Event>> selectedEvents;


  List<dynamic> events(date) => [
        'Independence Day',
      ];
  // Add more holidays as needed
@override
  void initState() {
    // TODO: implement initState
  selectedEvents = {};
    super.initState();
  }
  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }
  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text('add events'),
            content: TextField(controller: _eventController,),
            actions: [
             TextButton(onPressed: (){}, child: const Icon(Icons.add))
            ],
          );
        });
      },child: Center(child: Icon(Icons.add),),),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:const  EdgeInsets.all(16.0),
              child: TableCalendar(
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },


                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
               selectedDay = selectDay;
               focusedDay = focusDay;
                  });

                },
                eventLoader: events,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) => events.isNotEmpty
                      ? Container(
                          height: 16,
                          margin:const EdgeInsets.only(bottom: 10, left: 2, right: 2),
                          padding:
                             const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD4EEF8),
                          ),
                          child: Text(
                            '${events.length} sessions',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 8.0),
                          ),
                        )
                      : null,
                ),
                daysOfWeekHeight: 30,
                focusedDay: selectedDay,
                rowHeight: 100,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.black,
                    fontSize:16,
                  ),
                  weekendStyle: TextStyle(
                    color: Colors.red,
                   fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                daysOfWeekVisible: true,
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                weekendDays: [6],
                holidayPredicate: (date) => date.day == 28,
                firstDay: DateTime.utc(2022, 10, 16),
                lastDay: DateTime.utc(2030, 10, 16),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),

                  ),
                  defaultTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                    tableBorder: TableBorder(
                      horizontalInside: BorderSide(color: Colors.grey.withOpacity(0.5)),
                      verticalInside: BorderSide(color: Colors.grey.withOpacity(0.5)),
                    ),
                    weekendDecoration: BoxDecoration(
                      color: Color(0xFFF5D7D7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),

                    weekendTextStyle: const TextStyle(color: Colors.red),
                    cellMargin: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 6,
                    ),
                    holidayTextStyle:
                        const TextStyle(color: Colors.red, fontSize: 24),
                    holidayDecoration:
                         BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                    cellAlignment: Alignment.center,
                    cellPadding: const EdgeInsets.symmetric(vertical: 10),
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFF29A9DB),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class Event {
  final String title;
  Event({required this.title});
  String toString()=>this.title;
}


