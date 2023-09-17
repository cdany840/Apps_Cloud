import 'package:flutter/widgets.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/fruit_store/fruit_app.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:pmsn20232/screens/onboarding/onboarding.dart';
import 'package:pmsn20232/screens/task_screen.dart';

Map<String, WidgetBuilder> getRoutes(){
  return{
    '/login' : (BuildContext context) => const LoginScreen(),
    '/dash' : (BuildContext context) => const DashboardScreen(),
    '/task' : (BuildContext context) => const TaskScreen(),
    '/fruitApp' : (BuildContext context) => const FruitApp(),
    '/onboarding' : (BuildContext context) => Onboarding()
  };
}