import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/assets/styles_app.dart';
import 'package:pmsn20232/routes.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalValues.configPrefs();

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
          home: GlobalValues.prefsCheck.getBool('checkValue') ?? false
                ? const DashboardScreen() // * True
                : const LoginScreen(), // * False
          routes: getRoutes(),
          theme: value
                  ? StylesApp.darkTheme(context)
                  : StylesApp.lightTheme(context)
        );
      }
    );
  }
}