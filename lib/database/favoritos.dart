import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pmsn20232/models/popular_model.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class FavoritosDB {
  static const nameDB = 'Agenda';
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
      String query = '''create table tblFavorites(
                          idMovie integer primary key,
                          id int,
                          overview text,
                          posterPath varchar(50),
                          title varchar(50)
                        );''';
      db.execute(query);
    }

  Future<int> insert(String tblName, Map<String, dynamic> data) async {
    var connection = await getDatabase;

    return connection!.insert(tblName, data);
  }

  Future<int> delete(String tblName, int id) async {
    var connection = await getDatabase;
    return connection!.delete(tblName, 
                              where: 'id = ?', 
                              whereArgs: [id]);
  }

  Future<List<PopularModel>> getAllFavoriteMovies() async {
    var connection = await getDatabase;
    var result = await connection!.query('tblFavorites');

    return result.map((movie) => PopularModel.fromJson(movie)).toList();
  }

  Future<List<PopularModel>> getMovieById(int id) async {
    var connection = await getDatabase;
    var result = await connection!.query('tblFavorites',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.map((task) => PopularModel.fromJson(task)).toList();
  }
    
}