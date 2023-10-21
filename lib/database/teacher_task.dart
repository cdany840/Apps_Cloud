import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pmsn20232/models/task_teacher_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class TeacherTaskBD {
  
  static const nameDB = 'TeacherTask';
  static int versionDB = 1;

  static Database? _database;

  Future<Database?> get getDatabase async {

    if( _database != null ) return _database!;
    return _database = await _initDatabase();

  }
  
  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables
    );
  }
  
  FutureOr<void> _createTables (Database db, int version) {
      String query = '''
                        create table tblCourse(
                          idCourse   integer primary key,
                          nameCourse varchar(50)
                        );
                     ''';
      db.execute(query);
      query = ''' 
                create table tblTeacher(
                  idTeacher   integer primary key,
                  nameTeacher varchar(50),
                  email       varchar(50),
                  idCourse    integer,
                  foreign key(idCourse) REFERENCES tblCourse(idCourse)
                );  
              ''';
      db.execute(query);
      query = ''' 
                create table tblTask(
                  idTask    integer primary key,
                  nameTask  varchar(50),
                  dateExp   datetime,
                  dateRem   datetime,
                  dscTask   varchar(50),
                  doing     integer,
                  idTeacher integer,
                  foreign key(idTeacher) REFERENCES tblTeacher(idTeacher)
                );
              ''';
      db.execute(query);
    }

  Future<int> insert(String tblName, Map<String, dynamic> data) async {
    var connection = await getDatabase;

    return connection!.insert(tblName, data);
  }

  Future<int> update(String tblName, Map<String, dynamic> data, String whereKey) async {
    var connection = await getDatabase;

    return connection!.update(tblName, data, 
                              where: '$whereKey = ?', 
                              whereArgs: [data[whereKey]]);
  }

  Future<int> delete(String tblName, int id, String whereKey) async {
    var connection = await getDatabase;

    return connection!.delete(tblName, 
                              where: '$whereKey = ?', 
                              whereArgs: [id]);
  }

  Future<List<CourseModel>> getCourseData() async {
    var connection = await getDatabase;
    var result = await connection!.query('tblCourse');

    return result.map((task) => CourseModel.fromMap(task)).toList();
  }

  Future<List<TeacherModel>> getTeacherData() async {
    var connection = await getDatabase;
    var result = await connection!.query('tblTeacher');

    return result.map((task) => TeacherModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> getTaskData() async {
    var connection = await getDatabase;
    var result = await connection!.query('tblTask');

    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> getTaskByDoing(int doing) async {
    var connection = await getDatabase;
    var result = await connection!.query('tblTask',
      where: 'doing = ?',
      whereArgs: [doing],
    );

    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> getTaskByDate(String date) async {
    var connection = await getDatabase;
    var result = await connection!.query('tblTask',
      where: 'dateExp = ?',
      whereArgs: [date],
    );

    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<bool> getForeignKey(String tblName, String colForKey, int valForKey) async {
    final connection = await getDatabase;
    final List<Map<String, dynamic>> result = await connection!.query(tblName, 
      where: '$colForKey = ?',
      whereArgs: [valForKey] 
    );

    return result.isEmpty;
  }

}