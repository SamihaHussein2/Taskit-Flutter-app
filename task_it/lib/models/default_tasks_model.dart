import 'package:flutter/material.dart';
import 'package:task_it/models/task.dart';
//import 'package:hexcolor/hexcolor.dart';
import '/constants/custom_colors.dart';

class DefaultTasksList {
  final int id;
  IconData? taskIcon;
  String? taskTitle;
  Color? backgroundColor;
  Color? iconColor;
  Color? buttonColor;
  num? numberOfUnfinishedTasks;
  num? numberOfCompletedTasks;
  List<Map<String,dynamic>>? desc;
 // List<Task>? tasks;
  bool? isAddNewTask; //isLast

  DefaultTasksList(
      {required this.id,
      this.taskIcon,
      this.taskTitle,
      this.backgroundColor,
      this.iconColor,
      this.buttonColor,
      this.numberOfUnfinishedTasks,
      this.numberOfCompletedTasks,
      this.desc,
     // this.tasks,
      this.isAddNewTask = false}); //End of constructor

      c(){
        return this.desc;
      }

  static List<DefaultTasksList> generateTasks() {
    return [
      DefaultTasksList(
        id: 1,
        taskIcon: Icons.person_rounded,
        taskTitle: 'Personal',
        backgroundColor: Color(0xFF92C9DD),
        iconColor: CustomColors.Cultured,
        buttonColor: CustomColors.Cultured,
        numberOfUnfinishedTasks: 2,
        numberOfCompletedTasks: 3,
        desc: [
          {
            'time': '9:00 AM',
            'title': 'go for a walk with dog',
            'slot':'9:00 am to 10:00 AM',
            'timelineColor': Colors.pink[50],
            'backGroundColor' : CustomColors.Cultured
          },
          {
            'time': '10:00 AM',
            'title': 'workout',
            'slot':'10:00 am to 12:00 pm',
            'timelineColor': Colors.blue[100],
            'backGroundColor' : CustomColors.SeaShell,
          },
          {
            'time': '11:00 am',
            'title': '',
            'slot':'',
            'timelineColor': CustomColors.Midnight,
          },
          {
            'time': '12:00 pm',
            'title': '',
            'slot':'',
            'timelineColor': Colors.deepOrange[300],
          },
          {
            'time': '1:00 pm',
            'title': 'call with client',
            'slot':'1:00 pm to 2:00 pm',
            'timelineColor': Colors.grey.withOpacity(0.3),
            'backGroundColor' : CustomColors.YellowOrange,
          },
           {
            'time': '2:00 pm',
            'title': '',
            'slot':'',
            'timelineColor': CustomColors.YellowOrange,
          },
          {
            'time': '3:00 pm',
            'title': '',
            'slot':'',
            'timelineColor': CustomColors.Cultured,
          },
        ]
      ),
      DefaultTasksList(
        id: 2,
        taskIcon: Icons.school_rounded,
        taskTitle: 'University',
        backgroundColor: Color(0xFFFFCF99),
        iconColor: CustomColors.Cultured,
        buttonColor: CustomColors.Cultured,
        numberOfUnfinishedTasks: 2,
        numberOfCompletedTasks: 3,
      ),
      DefaultTasksList(
        id: 3,
        taskIcon: Icons.shopping_basket_outlined,
        taskTitle: 'Groceries',
        backgroundColor: Color(0xFFEF8354),
        iconColor: CustomColors.Cultured,
        buttonColor: CustomColors.Cultured,
        numberOfUnfinishedTasks: 2,
        numberOfCompletedTasks: 3,
      ),
      
      DefaultTasksList(id: 0,isAddNewTask: true),
    ];
  }
}
