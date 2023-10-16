import 'package:flutter/material.dart';

const Color _customColor = Color(0xFF5C11D4);

const List<Color> _colorThemes = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

class StylesApp{

  final int selectedColor;

  StylesApp({
    this.selectedColor = 0
  }): assert (selectedColor >= 0 && selectedColor <= _colorThemes.length-1, 
              'Colors must be between 0 and ${ _colorThemes.length }'); 

  // ! Descomentar y agregar "BuildContext context" como parámetro.
  ThemeData lightTheme(){
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[3],
      brightness: Brightness.dark,
    );
    // final theme = ThemeData.light(useMaterial3: true);
    // return theme.copyWith(
    //   primaryColor: Color.fromARGB(255, 131, 42, 72),
    //   colorScheme:Theme.of(context).colorScheme.copyWith(
    //     primary: const Color.fromARGB(255, 85, 141, 2) //rgb(85, 141, 2)
    //   ) 
    // );
  }

  // ! Descomentar y agregar "BuildContext context" como parámetro.
  ThemeData darkTheme(){
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[1],
      brightness: Brightness.light,
    );
    // final theme = ThemeData.dark(useMaterial3: true);
    // return theme.copyWith(
    //   //primaryColor: Color.fromARGB(255, 131, 42, 72),
    //   colorScheme:Theme.of(context).colorScheme.copyWith(
    //     primary: const Color.fromARGB(255, 112, 121, 211) //rgb(112, 121, 211)
    //   ) 
    // );
  }
}