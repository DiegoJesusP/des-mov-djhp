import 'package:flutter/material.dart';
import 'package:flutter_application_1/Student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Aplicacion Flutter de DiegoJ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String name = 'Diego';
  int edad = 21;
  bool variable = true;

  final TextEditingController _txtNameCTRL = TextEditingController();
  final TextEditingController _txtStudentIdCTRL = TextEditingController();

  final Student student = Student("Estudiante 1", "Matricula1");

  // Lista de estudiantes
  List<Student> studentList = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter <= 0) {
      _showMyDialog();
    } else {
      setState(() {
        _counter--;
      });
    }
  }

  Widget _getAllStudents() {
    if (studentList.isEmpty) {
      return const Text("No hay estudiantes agregados");
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text("Student´s list:"),
        const SizedBox(height: 12),
        ...studentList.map((s) => Text("- ${s.name} (${s.studentId})")).toList(),
      ],
    );
  }

  void _addStudent() {
    final name = _txtNameCTRL.text.trim();
    final studentId = _txtStudentIdCTRL.text.trim();

    if (name.isEmpty || studentId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("El nombre y el ID no pueden estar vacíos")),
      );
      return;
    }
    setState(() {
      studentList.add(Student(name, studentId));
    });
    _txtNameCTRL.clear();
    _txtStudentIdCTRL.clear();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('No puedes tener nuemros negativos'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Agregar o quitar numero:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                controller: _txtNameCTRL,
                decoration: const InputDecoration(
                  labelText: "Name: ",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                controller: _txtStudentIdCTRL,
                decoration: const InputDecoration(
                  labelText: "Student Id: ",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: _addStudent,
                child: const Text("Add Student"),
              ),
            ),
            const SizedBox(height: 15),
            Text('Nombre: $name'),
            Text('Edad: $edad'),
            Text('Booleano: $variable'),
            const SizedBox(height: 15),
            Text("Student1: ${student.name}"),
            Text("Student1: ${student.studentId}"),
            _getAllStudents(),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
