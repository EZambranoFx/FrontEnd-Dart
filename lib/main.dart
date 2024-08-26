import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendario de Citas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDate = DateTime.now();
  final _appointments = <DateTime, List<String>>{};
  final _appointmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario de Citas'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDate,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _appointmentController,
              decoration: InputDecoration(
                labelText: 'Nueva cita',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final appointment = _appointmentController.text;
              if (appointment.isNotEmpty) {
                setState(() {
                  if (_appointments.containsKey(_selectedDate)) {
                    _appointments[_selectedDate]!.add(appointment);
                  } else {
                    _appointments[_selectedDate] = [appointment];
                  }
                  _appointmentController.clear();
                });
              }
            },
            child: Text('Agregar cita'),
          ),
          Expanded(
            child: ListView(
              children: _appointments.entries
                  .where((entry) => isSameDay(entry.key, _selectedDate))
                  .expand((entry) => entry.value.map((app) => ListTile(
                        title: Text(app),
                      )))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
