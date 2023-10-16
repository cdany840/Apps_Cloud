import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/custom/widgets/custom_widget.dart';
import 'package:pmsn20232/database/teacher_task.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:pmsn20232/widgets/shared/cards/card_teacher.dart';

class AddTeacher extends StatefulWidget {
  AddTeacher({super.key, this.teacherModel});
  TeacherModel? teacherModel;

  List<TeacherModel> teachers = [];

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {

  TeacherTaskBD? teacherTaskBD;
  TextEditingController txtConTeacher = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  int? dropDownValue;
  List<String> dropDownValues = [];

  @override
  void initState() {
    super.initState();
    teacherTaskBD = TeacherTaskBD();
    fetchCourseData();
    if(widget.teacherModel != null) {
      txtConTeacher.text = widget.teacherModel!.nameTeacher!;
      txtConEmail.text = widget.teacherModel!.email!;
      dropDownValue = widget.teacherModel!.idCourse!;
    }
  }


  Future<void> fetchCourseData() async {
    List<CourseModel> courseData = await teacherTaskBD!.getCourseData();
    setState(() {
      dropDownValues.clear();
      for (var course in courseData) {
        String nameCourse = course.nameCourse!;
        dropDownValues.add(nameCourse);
      }
    });
  }

  onChanged(value) {
    setState(() {
      dropDownValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 20 ),
        CustomTextField(
          controller: txtConTeacher,
          labelText: 'Teacher'
        ),
        const SizedBox( height: 20 ),
        CustomTextField(
          controller: txtConEmail,
          labelText: 'Email'
        ),
        const SizedBox( height: 20 ),
        DropdownButton(
          hint: const Text( "Course" ),
          value: dropDownValue,
          onChanged: onChanged,
          items: dropDownValues.asMap().entries.map(
            (entry) => DropdownMenuItem(
              value: entry.key + 1,
              child: Text(entry.value),
            ),
          ).toList(),
        ),
        const SizedBox( height: 20 ),
        CustomElevatedButton(
          text: "Save Teacher",
          onPressed: () async {
            final isInsert = widget.teacherModel == null;
            const tableName = 'tblTeacher';
            final operation = isInsert ? 'Inserción' : 'Actualización';

            final result = isInsert
                  ? await teacherTaskBD!.insert(tableName, {
                      'nameTeacher': txtConTeacher.text,
                      'email': txtConEmail.text,
                      'idCourse': dropDownValue!,
                    })
                  : await teacherTaskBD!.update(tableName, {
                      'idTeacher': widget.teacherModel!.idTeacher,
                      'nameTeacher': txtConTeacher.text,
                      'email': txtConEmail.text,
                      'idCourse': dropDownValue,
                      },
                      'idTeacher'
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
                future: teacherTaskBD!.getTeacherData(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<TeacherModel>> snapshot
                  ) {
                    if(snapshot.hasData) {
                      widget.teachers = snapshot.data!;
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardTeacher(
                            teacherModel: widget.teachers[index],
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