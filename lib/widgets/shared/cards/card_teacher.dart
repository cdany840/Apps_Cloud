import 'package:flutter/material.dart';
import 'package:pmsn20232/database/teacher_task.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:pmsn20232/screens/add_teacher_task.dart';
import 'package:pmsn20232/widgets/shared/buttons_up_del.dart';

// ignore: must_be_immutable
class CardTeacher extends StatefulWidget {
  CardTeacher({
    super.key, 
    required this.teacherModel, 
    this.teacherTaskBD, 
    // this.teacherModel
  });

  TeacherModel teacherModel;
  TeacherTaskBD? teacherTaskBD;

  @override
  State<CardTeacher> createState() => _CardTeacherState();
}

class _CardTeacherState extends State<CardTeacher> {

  TeacherTaskBD? teacherTaskNamesBD;

  @override
  void initState() {
    super.initState();    
    teacherTaskNamesBD = TeacherTaskBD();
    fetchCourseData();
  }

  Map<int, dynamic>? courseNames;

  Future<void> fetchCourseData() async {
    List<CourseModel> courseData = (await teacherTaskNamesBD!.getCourseData());
    if (mounted) {
      setState(() {
        courseNames?.clear();
        courseNames = {}; // Inicializa el mapa
        for (var course in courseData) {
          int idCourse = course.idCourse!;
          String nameCourse = course.nameCourse!;
          courseNames![idCourse] = nameCourse;
        }
      });
    }
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
                Text(widget.teacherModel.nameTeacher!),
                Text(widget.teacherModel.email!),
                Text( "Course: ${courseNames?[widget.teacherModel.idCourse] ?? 'Pendiente'}" )
              ],
            ),
          ),
          ButtonsUpDel(
            teacherTaskBD: widget.teacherTaskBD!, 
            tableName: "tblTeacher",
            id: "idTeacher",
            model: widget.teacherModel.idTeacher,
            idForeignKey: widget.teacherModel.idTeacher,
            builder: (context) => const AddTeacherTask(),
            screen: 'teacher',
            data: widget.teacherModel, 
            SizedBox: null,
          )
        ],
      ),
    );
  }
}