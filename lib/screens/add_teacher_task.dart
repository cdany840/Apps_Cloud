import 'package:flutter/material.dart';
import 'package:pmsn20232/database/teacher_task.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:pmsn20232/widgets/shared/bar_search/search_course.dart';
import 'package:pmsn20232/widgets/shared/bar_search/search_teacher.dart';
import 'package:pmsn20232/widgets/teacher_task/add_course.dart';
import 'package:pmsn20232/widgets/teacher_task/add_teach_task.dart';
import 'package:pmsn20232/widgets/teacher_task/add_teacher.dart';

class AddTeacherTask extends StatefulWidget {
  const AddTeacherTask({super.key});

  @override
  State<AddTeacherTask> createState() => _AddTeacherTaskState();
}

class _AddTeacherTaskState extends State<AddTeacherTask> {
  List<dynamic> models = [];  
  List<TeacherModel> teachers = [];  
  List<CourseModel> courses = [];  
  TeacherTaskBD? teacherTaskBD;

  @override
  void initState() {
    super.initState();
    teacherTaskBD = TeacherTaskBD();
    fetchData();
  }

  Future<void> fetchData() async {
    courses = await teacherTaskBD!.getCourseData();
    teachers = await teacherTaskBD!.getTeacherData();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    Widget widget;

    switch (arguments['screen']) {
      case 'teacher':
        widget = AddTeacher( teacherModel: arguments['data'] );
        break;
      case 'course':
        widget = AddCourse( courseModel: arguments['data'] );
        break;
      default:
        widget = AddTeachTask( taskModel: arguments['data'] );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: arguments['data'] != null ? const Text('Edit Element') : const Text('Add Element'),
        actions: <Widget>[
          if (arguments['screen'] == 'teacher')
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context, 
                  delegate: SearchTeacher(
                    listTeacher: teachers, 
                    screen: arguments['screen']
                  )
                );
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context, 
                  delegate: SearchCourse(
                    listCourse: courses,
                    screen: arguments['screen']
                  )
                );
              },
            )
        ]
      ),
      body: widget
    );
  }
}