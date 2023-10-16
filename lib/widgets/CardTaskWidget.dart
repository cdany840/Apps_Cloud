import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/agenda.dart';
import 'package:pmsn20232/models/task_model.dart';
import 'package:pmsn20232/screens/add_task.dart';

class CardTaskWidget extends StatelessWidget {
  CardTaskWidget({super.key, required this.taskModel, this.agendaDB});

  TaskModel taskModel;

  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.amber,
      ),
      margin: const EdgeInsets.only( top: 10 ),
      padding: const EdgeInsets.all( 6 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(taskModel.nameTask!),
              Text(taskModel.dscTask!),
              Text(taskModel.sttTask!),
            ],
          ),
          // Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => AddTask(taskModel: taskModel),
                    )
                  );
                  
                },
                child: const Icon(Icons.edit) // Image.asset('assets/icons/icon_orange.png', height: 50,)
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Mensaje del sistema'),
                        content: const Text('¿Deseas borrar la tarea?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              agendaDB!.delete('tblTask', taskModel.idTask!).then((value) {
                                Navigator.pop(context);
                                GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
                              });                        
                            }, 
                            child: const Text('Si.')
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context), 
                            child: const Text('No.')
                          )
                        ],
                      );
                    },
                  );
                }, 
                icon: const Icon(Icons.delete)
              ),
            ],
          )
        ],
      ),
    );
  }
}