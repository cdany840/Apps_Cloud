import 'package:flutter/material.dart';
import 'package:pmsn20232/database/teacher_task.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:pmsn20232/screens/add_teacher_task.dart';
import 'package:pmsn20232/widgets/shared/buttons_up_del.dart';

// ignore: must_be_immutable
class CardCourses extends StatefulWidget {
  CardCourses({
    super.key, 
    required this.courseModel, 
    this.teacherTaskBD, 
    // this.teacherModel
  });

  CourseModel courseModel;
  TeacherTaskBD? teacherTaskBD;

  @override
  State<CardCourses> createState() => _CardCoursesState();
}

class _CardCoursesState extends State<CardCourses> {

  TeacherTaskBD? teacherTaskNamesBD;

  @override
  void initState() {
    super.initState();    
    teacherTaskNamesBD = TeacherTaskBD();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 180, 24, 204),
      ),
      margin: const EdgeInsets.only( top: 10 ),
      padding: const EdgeInsets.all( 6 ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.courseModel.nameCourse!),
              ],
            ),
          ),
          ButtonsUpDel(
            teacherTaskBD: widget.teacherTaskBD!, 
            tableName: "tblCourse",
            id: "idCourse",
            model: widget.courseModel.idCourse,
            idForeignKey: widget.courseModel.idCourse,
            builder: (context) => const AddTeacherTask(),
            screen: 'course',
            data: widget.courseModel,
            SizedBox: null,
          )
        ],
      ),
    );
  }
}