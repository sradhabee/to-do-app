



import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:new_to_do_app/utils/app_sessions.dart';
import 'package:new_to_do_app/view/alert_dialog_box/alert_dialog_box.dart';
import 'package:new_to_do_app/view/task_details/task_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

var taskBox = Hive.box(AppSessions.TASKBOX);
 List  taskKeys = [];
  @override
  void initState() {
   taskKeys=taskBox.keys.toList();
   setState(() {
     
   });
    super.initState();
  }


  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogBox(
          onSave: () {
            setState(() {});
            taskKeys=taskBox.keys.toList();
            Navigator.pop(context); 
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      taskBox.delete(taskKeys[index]);
      taskKeys=taskBox.keys.toList();
      Navigator.of(context).pop(HomeScreen());
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        shape: CircleBorder(),
        child: Icon(Icons.add),
        onPressed: createTask,
      ),
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text(
          "TO DO",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.yellow.shade200),
        child: ListView.separated(
          itemCount: taskKeys.length,
          itemBuilder: (context, index) {
            var currentTask = taskBox.get(taskKeys[index]);
            return TaskDetails(
            taskTitle: currentTask["taskTitle"],
            showDate: currentTask["showDate"],
            onDelete: () => deleteTask(index),
            index: index,
          );},
          separatorBuilder: (context, index) => SizedBox(
            height: 8,
          ),
        ),
      ),
    );
  }
}
