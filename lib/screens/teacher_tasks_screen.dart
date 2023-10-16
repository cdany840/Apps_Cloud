import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/custom/widgets/custom_widget.dart';
import 'package:pmsn20232/database/teacher_task.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:pmsn20232/widgets/shared/bar_search/search_teacher_task.dart';
import 'package:pmsn20232/widgets/shared/cards/card_task_teacher.dart';
import 'package:pmsn20232/widgets/shared/teacher_task_buttons.dart';

class TeacherTaskScreen extends StatefulWidget {
  TeacherTaskScreen({super.key, this.taskModel});
  TaskModel? taskModel;

  @override
  State<TeacherTaskScreen> createState() => _TeacherTaskScreenState();
}

class _TeacherTaskScreenState extends State<TeacherTaskScreen> {

  TeacherTaskBD? teacherTaskBD;

  @override
  void initState() {
    super.initState();
    teacherTaskBD = TeacherTaskBD();
  }

  String dropDownValue = "3.- All";
  List<String> dropDownValues = [
      "1.- To Do",
      "2.- Doing",
      "3.- All"
  ];

  List<TaskModel> tasks = [];

  @override
  Widget build(BuildContext context) {
    
    onChanged(value) {
      dropDownValue = value;
      setState(() {

      });
    }

    final addBStatus = CustomDropdownButton(
      value: dropDownValue, 
      items: dropDownValues,
      onChanged: onChanged,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Task'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              Navigator.pushNamed(context, '/tableCalendar', arguments: {'tasks': tasks});
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: SearchTeacherTask(listTask: tasks, screen: "task")
              );
            },
          ),
        ]
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox( height: 20 ),
              addBStatus,
              const SizedBox( height: 20 ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: GlobalValues.flagTask,
                  builder: (context, value, _) {
                    return FutureBuilder(
                      future: dropDownValue != "3.- All"
                        ? teacherTaskBD!.getTaskByDoing(int.parse(dropDownValue.substring(0, 1)))
                        : teacherTaskBD!.getTaskData(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<TaskModel>> snapshot
                        ) {
                          if(snapshot.hasData) {
                            tasks = snapshot.data!;
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardTaskTeacher(
                                  taskModel: tasks[index],
                                  teacherTaskBD: teacherTaskBD,
                                );
                             }
                            );
                          } else {
                            if(snapshot.hasError) {
                              return const Center(
                                child: Text('Something was wrong!'),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }
                        }
                    );
                  }
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 60,
            right: 20,
            child: TeacherTaskButtons(teacherTaskBD: teacherTaskBD)
          ),
        ],
      ) 
    );
  }
}