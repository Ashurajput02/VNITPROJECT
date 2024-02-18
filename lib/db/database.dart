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
          username TEXT,
          visit TEXT,
          age TEXT,
          area TEXT,
          gender TEXT,
          uid TEXT,
          weight TEXT
        )
      ''');
    },
  );
}


  Future<void> insertUserData(
      {required String username, required String age, required String area, required String visit, required String gender,required String id,required String weight}) async {
    final Database db = await database;
    await db.insert(
      'user_data',
      {'username': username, 'age': age, 'area': area, 'visit': visit, 'gender': gender, 'uid': id, 'weight':weight},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllUserData() async {
    final Database db = await database;
    return await db.query('user_data');
  }
}
