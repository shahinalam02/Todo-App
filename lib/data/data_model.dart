import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List toDoLists = [];

  var mybox = Hive.box('MyBox');

  void createIntialData() {
    toDoLists = [];
  }

  void loadDara() {
    toDoLists = mybox.get('TODOLIST');
  }

  void updateData() {
    mybox.put('TODOLIST', toDoLists);
  }
}
