import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/custom/widgets/custom_widget.dart';
import 'package:pmsn20232/database/teacher_task.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:pmsn20232/notifications/teacher_task_notification.dart';

class AddTeachTask extends StatefulWidget {
  AddTeachTask({super.key, this.taskModel});
  TaskModel? taskModel;

  @override
  State<AddTeachTask> createState() => _AddTeachTaskState();
}

class _AddTeachTaskState extends State<AddTeachTask> {
  
  TeacherTaskBD? teacherTaskBD;

  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  TextEditingController txtConDateExp = TextEditingController();
  TextEditingController txtConDateRem = TextEditingController();

  String? dropDownValueTask;
  List<String> dropDownTaskValues = [
    "1.- To Do",
    "2.- Doing"
  ];
  int? dropDownValueTeacher;
  List<String> dropDownTeacherValues = [];

  Future<void> fetchCourseData() async {
    List<TeacherModel> teacherData = await teacherTaskBD!.getTeacherData();
    if (mounted) {
      setState(() {
        dropDownTeacherValues.clear();
        for (var teacher in teacherData) {
          String nameTeacher = teacher.nameTeacher!;
          dropDownTeacherValues.add(nameTeacher);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    teacherTaskBD = TeacherTaskBD();
    fetchCourseData();
    if(widget.taskModel != null) {
      txtConName.text = widget.taskModel!.nameTask!; 
      txtConDsc.text = widget.taskModel!.dscTask!; 
      txtConDateExp.text = widget.taskModel!.dateExp!; 
      txtConDateRem.text = widget.taskModel!.dateRem!; 
      dropDownValueTask = widget.taskModel!.doing! == 1 ? "1.- To Do" : "2.- Doing"; 
      dropDownValueTeacher = widget.taskModel!.idTeacher!;
    }
  }

  @override
  Widget build(BuildContext context) {

    onChangedTeacher(value) {
      setState(() {
        dropDownValueTeacher = value;
      });
    } 

    onChangedTask(value) {
      setState(() {
        dropDownValueTask = value;
      });
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(        
        children: [
          const SizedBox( height: 20 ),
          CustomTextField(
            controller: txtConName,
            labelText: 'Task'
          ),
          const SizedBox( height: 20 ),
          CustomTextFormField(
            controller: txtConDsc,
            text: 'Description',
            maxLines: 6,
          ),
          const SizedBox( height: 20 ),
          DateInputField(
            controller: txtConDateExp,
            label: "Task Expiration",
            onDateSelected: (DateTime selectedDate) {
              
            },
          ),
          const SizedBox( height: 20 ),
          DateInputField(
            controller: txtConDateRem,
            label: "Task Reminder",
            onDateSelected: (DateTime selectedDate) {
              
            },
          ),
          const SizedBox( height: 20 ),
          CustomDropdownButton(
            value: dropDownValueTask,
            items: dropDownTaskValues,
            onChanged: onChangedTask
          ),
          const SizedBox( height: 20 ),
          DropdownButton(
            hint: const Text( "Teacher" ),
            value: dropDownValueTeacher,
            onChanged: onChangedTeacher,
            items: dropDownTeacherValues.asMap().entries.map(
              (entry) => DropdownMenuItem(
                value: entry.key + 1,
                child: Text(entry.value),
              ),
            ).toList(),
          ),
          const SizedBox( height: 20 ),
          CustomElevatedButton(
            text: "Save Task",
            onPressed: () async {
              if (txtConName.text.isEmpty || txtConDsc.text.isEmpty || txtConDateExp.text.isEmpty || txtConDateRem.text.isEmpty || dropDownValueTask == null || dropDownValueTeacher == null) {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Campos'),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Los campos no pueden estar vacíos.'),
                        ]
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Aceptar'),
                          onPressed: (){
                            Navigator.of(context).pop();
                          }, 
                        )
                      ],
                    );
                  },
                );
              } else {
                scheduleNotification(txtConName.text, txtConDsc.text, DateFormat('yyyy-MM-dd').parse(txtConDateRem.text));
                showNotification(txtConName.text, 'Tarea Programada');

                GlobalValues.flagTask.value = !GlobalValues.flagTask.value; // ? Debería implementarse en los inserts
                final isInsert = widget.taskModel == null;
                const tableName = 'tblTask';
                final operation = isInsert ? 'Inserción' : 'Actualización';
      
                final result = isInsert
                      ? await teacherTaskBD!.insert(tableName, {
                          'nameTask': txtConName.text,
                          'dscTask': txtConDsc.text,
                          'dateExp': txtConDateExp.text,
                          'dateRem': txtConDateRem.text,
                          'doing': int.parse(dropDownValueTask!.substring(0, 1)),
                          'idTeacher': dropDownValueTeacher,
                        })
                      : await teacherTaskBD!.update(tableName, {
                          'idTask': widget.taskModel!.idTask,
                          'nameTask': txtConName.text,
                          'dscTask': txtConDsc.text,
                          'dateExp': txtConDateExp.text,
                          'dateRem': txtConDateRem.text,
                          'doing': int.parse(dropDownValueTask!.substring(0, 1)),
                        },
                        'idTask'
                        );
      
                final message = (result > 0) ? '$operation fue exitosa' : 'Ocurrió un error';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}

// * Custom Widget Date
class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(DateTime)? onDateSelected;

  const DateInputField({
    super.key, 
    required this.controller,
    required this.label,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white
          )
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white
          )
        ),
        icon: const Icon(Icons.calendar_today),
        labelText: label,
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          controller.text = formattedDate;
          if (onDateSelected != null) {
            onDateSelected!(pickedDate);
          }
        }
      },
    );
  }
}