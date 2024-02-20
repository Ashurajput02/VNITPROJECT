import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE user_data(
          id INTEGER PRIMARY KEY,
          value1 INTEGER,
          value2 INTEGER,
          value3 INTEGER
        )
      ''');
      },
    );
  }

  Future<void> insertUserData(
      {required int value1, required int value2, required int value3}) async {
    final Database db = await database;
    await db.insert(
      'user_data',
      {'value1': value1, 'value2': value2, 'value3': value3},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllUserData() async {
    final Database db = await database;
    return await db.query('user_data');
  }
}
