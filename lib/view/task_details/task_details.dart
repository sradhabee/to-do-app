


import 'package:flutter/material.dart';
import 'package:new_to_do_app/view/view_task_details/view_task_details.dart';

class TaskDetails extends StatefulWidget {
  final String taskTitle;
  final String showDate;
  final void Function()? onDelete;
  final int index;

  const TaskDetails({
    super.key,
    required this.taskTitle,
    required this.showDate,
    this.onDelete,
    required this.index,
  });

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  bool isTaskCompleted = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewTaskDetails(
            taskTitle: widget.taskTitle,
            showDate: widget.showDate,
            onDelete: widget.onDelete, index:widget.index,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        color: Colors.yellow.shade100,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isTaskCompleted,
                  onChanged: (bool? value) {
                    setState(() {
                      isTaskCompleted = value ?? false;


                      if (isTaskCompleted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                           
                         backgroundColor: Colors.green,
                            content: Text('Task completed!'),
                          ),
                        );
                      }
                    });
                  },
                ),
                Text(widget.taskTitle,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,
                decoration: isTaskCompleted?TextDecoration.lineThrough:TextDecoration.none),),
              ],
            ),
            Text(widget.showDate,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,
            decoration: isTaskCompleted?TextDecoration.lineThrough:TextDecoration.none),),
          ],
        ),
      ),
    );
    
  }
}
