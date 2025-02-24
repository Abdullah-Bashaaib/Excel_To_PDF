// يجب حفظ هذا الملف لإنشاء اي قاعدة بيانات

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  // this is made to not make init again and again
  static Database? _db;
  Future<Database> get db async {
    if (_db == null) _db = await initalDb();
    return _db!;
  }

  // here we init the database and creat the tables
  initalDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'test.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {

    print("onUpgrae =========================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name_student TEXT,
    age NUMBER,
    grade TEXT
  )
''');

    print("==============onCreat database and tables ================");
  }

// SELECT
  Future<List<Map>> readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

// INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    print(response);
    return response;
  }

// UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

// DELETE
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}

SqlDb sqlDb = SqlDb();
