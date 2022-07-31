import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class SQLHelper {
  static Future<Database> database() async {
    final sqlPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(sqlPath, 'patients.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE patients(id TEXT PRIMARY KEY, title TEXT, age TEXT, image TEXT, image2 TEXT, image3 TEXT, description TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await SQLHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await SQLHelper.database();
    return db.query(table);
  }
}
