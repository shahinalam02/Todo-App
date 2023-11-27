import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos_app/data/data_model.dart';
import 'package:todos_app/widgets/dialogbox.dart';
import 'package:todos_app/widgets/todotile.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
// reference the box
  final mybox = Hive.box("MyBox");

  final _controller = TextEditingController();
  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    if (mybox.get('TODOLIST') == null) {
      db.createIntialData();
    } else {
      db.loadDara();
    }
    super.initState();
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoLists[index][1] = !db.toDoLists[index][1];
    });
    db.updateData();
  }

  // creating add new task
  void addNewTask() {
    setState(() {
      db.toDoLists.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

// delete function
  void deleteTask(int index) {
    setState(() {
      db.toDoLists.removeAt(index);
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodosPage()));
    db.updateData();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => Dialogbox(
        controller: _controller,
        onSave: addNewTask,
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          backgroundColor: const Color(0xFF8C78FD),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text(
            "TO DO list",
            style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF8C78FD),
        ),
        body: ListView.builder(
          itemCount: db.toDoLists.length,
          itemBuilder: (context, index) => ToDoTile(
            taskName: db.toDoLists[index][0],
            taskComplete: db.toDoLists[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          ),
        ));
  }
}
