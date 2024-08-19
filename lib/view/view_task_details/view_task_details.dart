// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:new_to_do_app/dummy_db.dart';
// import 'package:share_plus/share_plus.dart';

// class ViewTaskDetails extends StatefulWidget {
//   final String taskTitle;
//   final String showDate;
//   final void Function()? onDelete;
//   const ViewTaskDetails({super.key, required this.taskTitle, required this.showDate, this.onDelete});

//   @override
//   State<ViewTaskDetails> createState() => _ViewTaskDetailsState();
// }

// class _ViewTaskDetailsState extends State<ViewTaskDetails> {
//   final taskController=TextEditingController();
//   final dateController = TextEditingController();

//   @override
//   void initState() {
//   taskController.text=widget.taskTitle;
//   dateController.text=widget.showDate;
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
       
      
//       backgroundColor: Colors.yellow.shade100,
      


   
//       floatingActionButton: FloatingActionButton(
//         shape: CircleBorder(),
//         backgroundColor: Colors.yellow,
//         child: Icon(Icons.check,color:Colors.black),
//         onPressed: (){
//         setState(() {
//             DummyDb.toDoList.add({'taskTitle':taskController.text,
//           'showDate':dateController.text});
          
          
//         });
           
            
        
         
         
//         }),
//       appBar: AppBar(
//          actions: [
//         IconButton(onPressed: (){
          
          
//           Share.share('${widget.taskTitle}\n${widget.showDate}');
//         }, icon: Icon(Icons.share,color: Colors.black,)),
//           SizedBox(width: 8,),
//          IconButton(onPressed:widget.onDelete, 
//           icon: Icon(Icons.delete,color: Colors.black,)),
//           SizedBox(width: 12,),
//         ],
//         backgroundColor: Colors.yellow,
//         title: Text("New Task",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
          
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("What is to be done?",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w800),),
//             SizedBox(height: 12,),
//             TextFormField(
//               controller: taskController,
//               decoration: InputDecoration(
//                hintStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),
//                 suffixIcon: Icon(Icons.keyboard_voice_rounded)
//               ),
//             ),
//             SizedBox(height: 72,),
//             Text("Due Date",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w800),),
//             SizedBox(height: 12,),
//             TextField(
              
//               controller: dateController,
//               decoration: InputDecoration(
                
//                 hintStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal),
//                 suffixIcon: IconButton(onPressed: () async {
//                   var selectedDate = await showDatePicker(context: context,initialDate: DateTime.now(),firstDate:DateTime(2024),lastDate: DateTime(2100) );
//                   if(selectedDate!=null){
//                     dateController.text= DateFormat("dd-MMM-yy").format(selectedDate);
                    
//                   }
//                 }, icon: Icon(Icons.calendar_month_outlined))
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:new_to_do_app/utils/app_sessions.dart';
import 'package:new_to_do_app/view/home_screen/home_screen.dart';
import 'package:share_plus/share_plus.dart';

class ViewTaskDetails extends StatefulWidget {
  final String taskTitle;
  final String showDate;
  final void Function()? onDelete;
  final int index;
  
  const ViewTaskDetails({super.key, required this.taskTitle, required this.showDate, this.onDelete, required this.index});

  @override
  State<ViewTaskDetails> createState() => _ViewTaskDetailsState();
}

class _ViewTaskDetailsState extends State<ViewTaskDetails> {
  var taskBox = Hive.box(AppSessions.TASKBOX);
   List  taskKeys = [];
  final taskController = TextEditingController();
  final dateController = TextEditingController();
  bool isEditing = false; 

  @override
  void initState() {
    taskController.text = widget.taskTitle;
    dateController.text = widget.showDate;
   taskKeys=taskBox.keys.toList();

  
    super.initState();
  }

  
 
  
   


  void editButton(){
    setState(() {
      isEditing=!isEditing;
    });
  }

  void editTask(){
    if(isEditing){
      setState(() {
      
      taskBox.put(taskKeys[widget.index],{
         'taskTitle':taskController.text,
       'showDate':dateController.text

      });
       
     
    });
     
     Navigator.of(context).pop(HomeScreen());
     taskKeys=taskBox.keys.toList();
  }


    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.yellow,
        child: Icon(Icons.check, color: Colors.black),
       

        onPressed: editTask,
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Share.share('${taskController.text}\n${dateController.text}');
            },
            icon: Icon(Icons.share, color: Colors.black),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: widget.onDelete,
            icon: Icon(Icons.delete, color: Colors.black),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: editButton,
            icon: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: Colors.black,
            ),
            

             

          ),
          SizedBox(width: 12),
        ],
        backgroundColor: Colors.yellow,
        title: Text(
          "Task Details",
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What is to be done?",
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: taskController,
              enabled: isEditing, 
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),
                suffixIcon: Icon(Icons.keyboard_voice_rounded),
              ),
            ),
            SizedBox(height: 72),
            Text(
              "Due Date",
              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 12),
            TextField(
              controller: dateController,
              enabled: isEditing, 
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),
                suffixIcon: isEditing
                    ? IconButton(
                        onPressed: () async {
                          var selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null) {
                            dateController.text = DateFormat("dd-MMM-yy").format(selectedDate);
                          }
                        },
                        icon: Icon(Icons.calendar_month_outlined),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

     