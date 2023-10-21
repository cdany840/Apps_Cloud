import 'package:flutter/widgets.dart';
import 'package:pmsn20232/screens/add_task.dart';
import 'package:pmsn20232/screens/add_teacher_task.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/detail_movie_screen.dart';
import 'package:pmsn20232/screens/fruit_store/fruit_app.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:pmsn20232/screens/onboarding/onboarding.dart';
import 'package:pmsn20232/screens/popular_screen.dart';
import 'package:pmsn20232/screens/table_calendar_screen.dart';
import 'package:pmsn20232/screens/task_screen.dart';
import 'package:pmsn20232/screens/teacher_tasks_screen.dart';
import 'package:pmsn20232/screens/test_provider_screen.dart';

Map<String, WidgetBuilder> getRoutes(){
  return{
    '/login' : (BuildContext context) => const LoginScreen(),
    '/dash' : (BuildContext context) => const DashboardScreen(),
    '/task' : (BuildContext context) => const TaskScreen(),
    '/fruitApp' : (BuildContext context) => const FruitApp(),
    '/onboarding' : (BuildContext context) => Onboarding(),
    '/addTask' : (BuildContext context) => AddTask(),
    '/popular' : (BuildContext context) => const PopularScreen(),
    '/teacherTask' : (BuildContext context) => TeacherTaskScreen(),
    '/addTeacherTask' : (BuildContext context) => const AddTeacherTask(),
    '/tableCalendar' : (BuildContext context) => const TableCalendarScreen(),
    '/detailMovie': (BuildContext context) => const DetailMovieScreen(),
    '/testP': (BuildContext context) => const TestProviderScreen(),
  };
}