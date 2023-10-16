import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/teacher_task.dart';

class ButtonsUpDel extends StatefulWidget {
  ButtonsUpDel({
    super.key,
    required this.teacherTaskBD,
    required this.tableName,
    required this.id,
    required this.builder,
    required this.screen,
    this.model,
    this.data,
    this.checkbox, required SizedBox 
  });

  final WidgetBuilder builder;
  late TeacherTaskBD teacherTaskBD;
  final String tableName;
  final String id;
  final String screen;
  final dynamic model;
  final dynamic data;
  final Widget? checkbox; 

  @override
  State<ButtonsUpDel> createState() => _ButtonsUpDelState();
}

class _ButtonsUpDelState extends State<ButtonsUpDel> {
  @override
  void initState() {
    super.initState();
    widget.teacherTaskBD = TeacherTaskBD();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: widget.builder,
                  settings: RouteSettings(
                    arguments: {'screen': widget.screen, 'data': widget.data},
                  )
                ),
              );
              
            },
            child: const Icon(Icons.edit)
          ),
          widget.checkbox ?? const SizedBox(height: 20),
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
                          try {
                            widget.teacherTaskBD.delete(widget.tableName, widget.model!, widget.id).then((value) {
                              Navigator.pop(context);
                              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
                            });
                          } catch (e) {
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Relaciones foráneas'),
                                  content: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Hay una relación con otro resgistro, borra primero el otro registro.'),
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
                          }
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
      ),
    );
  }
}