



import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:new_to_do_app/utils/app_sessions.dart';

class AlertDialogBox extends StatefulWidget {
  final Function()? onSave;

  AlertDialogBox({super.key, required this.onSave});

  @override
  State<AlertDialogBox> createState() => _AlertDialogBoxState();
}

class _AlertDialogBoxState extends State<AlertDialogBox> {
  final taskController = TextEditingController();
  final dateController = TextEditingController();
  var taskBox = Hive.box(AppSessions.TASKBOX);
  List  taskKeys = [];
  @override
  void initState() {
   taskKeys=taskBox.keys.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow.shade400,
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextFormField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: "Enter new task",
                hintStyle: TextStyle(fontWeight: FontWeight.w400),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 18),
            TextFormField(
              readOnly: true,
              controller: dateController,
              decoration: InputDecoration(
                hintText: "Due Date",
                hintStyle: TextStyle(fontWeight: FontWeight.w400),
                suffixIcon: IconButton(
                  onPressed: () async {
                    var selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) {
                      dateController.text =
                          DateFormat("dd-MMM-y").format(selectedDate);
                    }
                  },
                  icon: Icon(Icons.calendar_month_outlined, color: Colors.black),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (taskController.text.isNotEmpty &&
                        dateController.text.isNotEmpty) {
                      taskBox.add({
                        'taskTitle': taskController.text,
                        'showDate': dateController.text,

                      });

                      widget.onSave?.call();
                       taskKeys=taskBox.keys.toList();
                      
                    }
                    
                    
                  },
                 
                  
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade200,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black)),
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(width: 18),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade200,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black)),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
