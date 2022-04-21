import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timepro/remind.dart';

class calScreen extends StatefulWidget {

  const  calScreen({Key? key}) : super(key: key);

  @override
  calScreenState createState() => calScreenState();
}

class calScreenState extends State<calScreen>with TickerProviderStateMixin{
  //late Map<DateTime, List<Event>> selectedEvents;
  late AnimationController _animationController;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
/*
  @override
  void initState(){
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: Colors.deepPurple,
      ),
      body: TableCalendar(focusedDay: selectedDay, firstDay: DateTime.utc(2022), lastDay: DateTime.utc(2099),
      onDaySelected: (DateTime selectDay, DateTime focusDay){
        setState(() {
          selectedDay = selectDay;
          focusedDay = focusDay;
        });
        print(focusedDay);
    },
    selectedDayPredicate: (DateTime date){
        return isSameDay(selectedDay, date);
    },
        //eventLoader: _getEventsfromDay,
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
    image: DecorationImage(image: AssetImage('assets/timeb2.jpg'), fit: BoxFit.fill),
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
        onPressed: () => { Navigator.push(context, MaterialPageRoute(builder: (context) => addReminderPage()))},
        ),
    );
  }
}
