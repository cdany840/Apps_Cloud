import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/agenda.dart';
import 'package:pmsn20232/models/task_model.dart';
import 'package:pmsn20232/widgets/CardTaskWidget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
 
 AgendaDB? agendaDB;

 @override
  void initState() {    
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addTask').then((value) {
                setState(() {
                  
                });
              });
            },
            icon: const Icon(Icons.task))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValues.flagTask,
        builder: (context, value, _) {
          return FutureBuilder(
                  future: agendaDB!.getAllTask(),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<TaskModel>> snapshot
                    ) {
                      if(snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardTaskWidget(
                              taskModel: snapshot.data![index],
                              agendaDB: agendaDB,
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
    );

  }
}