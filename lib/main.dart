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
      home: LoginPage(),  // Establece LoginPage como la pantalla principal
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Formulario de inicio de sesión'),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  // Aquí puedes manejar el inicio de sesión, por ejemplo, validando la entrada
                  if (username.isNotEmpty && password.isNotEmpty) {
                    // Simulación de inicio de sesión exitoso
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Inicio de sesión exitoso para $username')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, completa todos los campos')),
                    );
                  }
                },
                child: Text('Iniciar sesión'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                child: Text('Registrarse'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: Text('Ir al Calendario de Citas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Formulario de registro'),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  // Aquí puedes manejar el registro del usuario, por ejemplo, validando la entrada
                  if (username.isNotEmpty && password.isNotEmpty) {
                    // Simulación de registro exitoso
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registro exitoso para $username')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, completa todos los campos')),
                    );
                  }
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Administrador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Lista de Citas'),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Fecha')),
                    DataColumn(label: Text('Hora')),
                    DataColumn(label: Text('Descripción')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('2024-08-25')),
                      DataCell(Text('10:00 AM')),
                      DataCell(Text('Cita de ejemplo')),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Aquí iría la funcionalidad para modificar
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Aquí iría la funcionalidad para eliminar
                            },
                          ),
                        ],
                      )),
                    ]),
                    // Puedes agregar más filas de ejemplo aquí
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDate = DateTime.now();
  final _appointments = <DateTime, List<Map<String, String>>>{};
  final _appointmentController = TextEditingController();
  final _nameController = TextEditingController();
  final _serviceController = TextEditingController();
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();
  bool _showPanel = false;
  String _action = 'Agregar';

  void _togglePanel(String action) {
    setState(() {
      _action = action;
      _showPanel = !_showPanel;
    });
  }

  void _saveAppointment() {
    final appointment = {
      'name': _nameController.text,
      'service': _serviceController.text,
      'time': _timeController.text,
      'notes': _notesController.text,
    };
    if (_appointments.containsKey(_selectedDate)) {
      _appointments[_selectedDate]!.add(appointment);
    } else {
      _appointments[_selectedDate] = [appointment];
    }

    setState(() {
      _showPanel = false;
      _nameController.clear();
      _serviceController.clear();
      _timeController.clear();
      _notesController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cita guardada exitosamente!')),
    );
  }

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
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _togglePanel('Agregar'),
                child: Text('Agregar cita'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => _togglePanel('Modificar'),
                child: Text('Modificar cita'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_appointments.containsKey(_selectedDate)) {
                      _appointments.remove(_selectedDate);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cita eliminada!')),
                      );
                    }
                  });
                },
                child: Text('Eliminar cita'),
              ),
            ],
          ),
          if (_showPanel) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nombre del cliente'),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 8),
                  Text('Tipo de servicio'),
                  TextField(
                    controller: _serviceController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 8),
                  Text('Hora de la cita'),
                  TextField(
                    controller: _timeController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 8),
                  Text('Notas'),
                  TextField(
                    controller: _notesController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _saveAppointment,
                    child: Text('Guardar'),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            child: ListView(
              children: _appointments.entries
                  .where((entry) => isSameDay(entry.key, _selectedDate))
                  .expand((entry) => entry.value.map((app) => ListTile(
                        title: Text('${app['name']} - ${app['service']}'),
                        subtitle: Text('Hora: ${app['time']} \nNotas: ${app['notes']}'),
                      )))
                  .toList(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Cerrar sesión'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
              );
            },
            child: Text('Ir a la Página de Administrador'),
          ),
        ],
      ),
    );
  }
}
