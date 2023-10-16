import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/custom/widgets/custom_widget.dart';
import 'package:pmsn20232/database/teacher_task.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:pmsn20232/widgets/shared/cards/card_course.dart';

class AddCourse extends StatefulWidget {
  AddCourse({super.key, this.courseModel});
  CourseModel? courseModel;

  List<CourseModel> courses = [];

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController txtConCourse = TextEditingController();

  TeacherTaskBD? teacherTaskBD;

  @override
  void initState() {
    super.initState();
    teacherTaskBD = TeacherTaskBD();
    if(widget.courseModel != null) {
      txtConCourse.text = widget.courseModel!.nameCourse!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 20 ),
        CustomTextField(
          controller: txtConCourse,
          labelText: 'Course'
        ),
        const SizedBox( height: 20 ),
        CustomElevatedButton(
          text: "Save Course",
          onPressed: () async {
            final isInsert = widget.courseModel == null;
            const tableName = 'tblCourse';
            final operation = isInsert ? 'Inserción' : 'Actualización';

            final result = isInsert
                  ? await teacherTaskBD!.insert(tableName, {
                      'nameCourse': txtConCourse.text,
                    })
                  : await teacherTaskBD!.update(tableName, {
                      'idCourse': widget.courseModel!.idCourse,
                      'nameCourse': txtConCourse.text,
                      },
                      'idCourse'
                  );

            final message = (result > 0) ? '$operation fue exitosa' : 'Ocurrió un error';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: GlobalValues.flagTask,
            builder: (context, value, _) {
              return FutureBuilder(
                future: teacherTaskBD!.getCourseData(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<CourseModel>> snapshot
                  ) {
                    if(snapshot.hasData) {
                      widget.courses = snapshot.data!;
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardCourses(
                            courseModel: widget.courses[index],
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
    );
  }
}