import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/teacher_task.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:pmsn20232/widgets/shared/cards/card_task_teacher.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({super.key});

  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  TeacherTaskBD? teacherTaskBD;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final Map<DateTime, List<TaskModel>> _events = {};
  List<String> listDates = [];
  List<TaskModel> listTasks = [];

  @override
  void initState() {
    super.initState();
    teacherTaskBD = TeacherTaskBD();
    fetchTaskData();
  }

  Future<void> fetchTaskData() async {
    listTasks = await teacherTaskBD!.getTaskData();
    List<TaskModel> listTask = await teacherTaskBD!.getTaskData();
    setState(() {
      for (var task in listTask) {
        final taskDate = DateTime.parse(task.dateExp!);
        if (_events.containsKey(taskDate)) {
          _events[taskDate]!.add(task);
        } else {
          _events[taskDate] = [task];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              List<Widget> dots = [];
              final dateFormat = DateTime.parse(DateFormat('yyyy-MM-dd').format(day));
              final events = _events[dateFormat] ?? [];
              dots = events.map((event) {
                return Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                );
              }).toList();
              if (day == _selectedDay) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: dots,
                );
              } else {
                return null;
              }
            },
          ),

            locale: "en_US",
            rowHeight: 45,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true
            ),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = selectedDay;
                _selectedDay = selectedDay;
              });
            },
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: GlobalValues.flagTask,
              builder: (context, value, _) {
                return FutureBuilder(
                  future: teacherTaskBD!.getTaskByDate(_selectedDay.toString().substring(0, 10)),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<TaskModel>> snapshot
                    ) {
                      if(snapshot.hasData) {
                        listTasks = snapshot.data!;
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardTaskTeacher(
                              taskModel: snapshot.data![index],
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
      ),
    );
  }
}