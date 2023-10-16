// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/assets/styles_app.dart';
import 'package:pmsn20232/notifications/teacher_task_notification.dart';
import 'package:pmsn20232/routes.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/login_screen.dart';

import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalValues.configPrefs();

  tzdata.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('America/Mexico_City'));

  runApp(const MyApp());
}

// TODO: Comentarios
// * Important
// ! Deprecated
// ? Should
// // Subrayar

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    GlobalValues.flagTheme.value = GlobalValues.prefsTheme.getBool('themeValue') ?? false;
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, //TODO: Quita la cabecera Debug
          routes: getRoutes(),
          theme: value
                  ? StylesApp().darkTheme()
                  : StylesApp().lightTheme(),
          home: GlobalValues.prefsCheck.getBool('checkValue') ?? false
                ? const DashboardScreen() // * True
                : const LoginScreen(), // * False
        );
      }
    );
  }
}