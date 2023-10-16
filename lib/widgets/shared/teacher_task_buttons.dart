import 'package:flutter/material.dart';
import 'package:pmsn20232/custom/widgets/custom_widget.dart';
import 'package:pmsn20232/database/teacher_task.dart';

class TeacherTaskButtons extends StatefulWidget {
  const TeacherTaskButtons({
    super.key,
    this.teacherTaskBD
  });

  final TeacherTaskBD? teacherTaskBD;

  @override
  State<TeacherTaskButtons> createState() => _TeacherTaskButtonsState();
}

class _TeacherTaskButtonsState extends State<TeacherTaskButtons> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          text: 'Teachers', 
          // icon: Icons.add_task,
          onPressed: () {
              Navigator.pushNamed(context, '/addTeacherTask', arguments: {'screen': "teacher", 'dataList': widget.teacherTaskBD});
          },
        ),
        const SizedBox( height: 10 ),
        CustomElevatedButton(
          text: 'Courses', 
          // icon: Icons.add_task,
          onPressed: () {
              Navigator.pushNamed(context, '/addTeacherTask', arguments: {'screen': "course", 'dataList': widget.teacherTaskBD});
          },
        ),
        const SizedBox( height: 10 ),
        CustomElevatedButton(
          text: 'Tasks', 
          // icon: Icons.add_task,
          onPressed: () {
              Navigator.pushNamed(context, '/addTeacherTask', arguments: {'screen': "task", 'dataList': widget.teacherTaskBD});
          },
        )
      ]
    );
  }
}