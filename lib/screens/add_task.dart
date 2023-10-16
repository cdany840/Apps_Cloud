import 'package:flutter/material.dart';
import 'package:pmsn20232/custom/widgets/custom_widget.dart';
import 'package:pmsn20232/database/agenda.dart';
import 'package:pmsn20232/models/task_model.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController txtContName = TextEditingController();
  TextEditingController txtContDsc = TextEditingController();
  String? dropDownValue;
  List<String> dropDownValues = [
      "Pendiente",
      "Completado",
      "En proceso"
  ];

  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    
    if(widget.taskModel != null) {
      
      txtContName.text = widget.taskModel!.nameTask!; 
      txtContDsc.text = widget.taskModel!.dscTask!; 
      
      switch (widget.taskModel!.sttTask!) {
        case 'E':
          dropDownValue = 'En Proceso';
          break;
        case 'C':
          dropDownValue = 'Completado';
          break;
        default:
          dropDownValue = 'Pendiente';
 }
    }

  }

  @override
  Widget build(BuildContext context) {
 
    final txtNameTask = CustomTextFormField(
      controller: txtContName, 
      text: 'Task'
    );
    
    final txtDscTask = CustomTextFormField(
      controller: txtContDsc, 
      text: 'Description',
      maxLines: 6,
    );

    final DropdownButton addBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues.map(
        (status) => DropdownMenuItem(
          value: status,
          child: Text(status)
        )
      ).toList(),
      onChanged: (value) {
        dropDownValue = value;
        setState(() {
          
        });
      }
    );

    final ElevatedButton btnSave = ElevatedButton(
      child: const Text('Save Task'),
      onPressed: () {
        if (widget.taskModel == null) {
          agendaDB!.insert('tblTask', { 
            'nameTask': txtContName.text,
            'dscTask': txtContDsc.text,
            'sttTask': dropDownValue?.substring(0, 1),
          }).then((value) {
            var msj = (value > 0) ? 'Inserción fue exitosa' : 'Ocurrió un error';
            var snackbar = SnackBar(
              content: Text(msj)
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
        } else {
          agendaDB!.update('tblTask', {
            'idTask': widget.taskModel!.idTask,
            'nameTask': txtContName.text,
            'dscTask': txtContDsc.text,
            'sttTask': dropDownValue?.substring(0, 1),
          }).then((value) {
            var msj = (value > 0) ? 'Actualización fue exitosa' : 'Ocurrió un error';
            var snackbar = SnackBar(
              content: Text(msj)
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
        }
        
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: widget.taskModel == null 
        ? const Text('Add Task')
        : const Text('Ud Task')
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            txtNameTask,
            const SizedBox(height: 8),
            txtDscTask,
            const SizedBox(height: 8),
            addBStatus,
            const SizedBox(height: 5),
            btnSave
          ],
        ),
      ),
    );
  }

}