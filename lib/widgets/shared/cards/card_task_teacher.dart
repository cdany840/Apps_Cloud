import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/teacher_task.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:pmsn20232/screens/add_teacher_task.dart';
import 'package:pmsn20232/widgets/shared/buttons_up_del.dart';

// ignore: must_be_immutable
class CardTaskTeacher extends StatefulWidget {
  CardTaskTeacher({
    super.key, 
    required this.taskModel, 
    this.teacherTaskBD, 
    // this.teacherModel
  });

  TaskModel taskModel;
  // TeacherModel? teacherModel;
  TeacherTaskBD? teacherTaskBD;

  @override
  State<CardTaskTeacher> createState() => _CardTaskTeacherState();
}

class _CardTaskTeacherState extends State<CardTaskTeacher> {

  TeacherTaskBD? teacherTaskNamesBD;
  bool stateCheck = false;

  @override
  void initState() {
    super.initState();    
    teacherTaskNamesBD = TeacherTaskBD();
    fetchCourseData();
  }

  Map<int, dynamic>? teacherNames;

  Future<void> fetchCourseData() async {
    List<TeacherModel> teacherData = (await teacherTaskNamesBD!.getTeacherData());
    if (mounted) {
      setState(() {
        teacherNames?.clear();
        teacherNames = {}; // Inicializa el mapa
        for (var teacher in teacherData) {
          int idTeacher = teacher.idTeacher!;
          String nameTeacher = teacher.nameTeacher!;
          teacherNames![idTeacher] = nameTeacher; // Usar idTeacher como clave
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    stateCheck = widget.taskModel.doing! == 1 ? false : true;

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 180, 24, 204),
      ),
      margin: const EdgeInsets.only( top: 10 ),
      padding: const EdgeInsets.all( 6 ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.taskModel.nameTask!),
                Text(widget.taskModel.dscTask!),
                Text("Expira: ${widget.taskModel.dateExp!}"),
                Text("Remember: ${widget.taskModel.dateRem!}"),
                Text("State: ${widget.taskModel.doing! == 1 ? "To Do" : "Doing"}"),
                Text( "Teacher: ${teacherNames?[widget.taskModel.idTeacher] ?? 'Pendiente'}" )
              ],
            ),
          ),
          Expanded(child: Container()),
          ButtonsUpDel(
            teacherTaskBD: widget.teacherTaskBD!, 
            tableName: "tblTask",
            id: "idTask",
            model: widget.taskModel.idTask,
            builder: (context) => const AddTeacherTask(),
            screen: 'taskTeacher',
            data: widget.taskModel,
            checkbox: Checkbox(
              value: stateCheck,
              onChanged: (value) async {
                await widget.teacherTaskBD!.update('tblTask', {
                    'idTask': widget.taskModel.idTask,
                    'nameTask': widget.taskModel.nameTask,
                    'dscTask': widget.taskModel.dscTask,
                    'dateExp': widget.taskModel.dateExp,
                    'dateRem': widget.taskModel.dateRem,
                    'doing': 2,
                  },
                  'idTask'
                );

                GlobalValues.flagTask.value = !GlobalValues.flagTask.value;

                stateCheck = value!;
              },
            ), SizedBox: null, 
          )
        ],
      ),
    );
  }
}