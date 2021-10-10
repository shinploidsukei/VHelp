import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vhelp_test/model/colorLog.dart';

class LogsDatabase {
  static final LogsDatabase instance = LogsDatabase._init();

  static Database? _database;

  LogsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('logs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableLogs (
      ${colorFields.id} $idType,
      ${colorFields.colorSaved} $integerType,
      ${colorFields.createTime} $textType
    )
    ''');
  }

  Future<colorLog> create(colorLog color) async {
    final db = await instance.database;

    final id = await db.insert(tableLogs, color.toJson());
    return color.copy(id: id);
  }

  Future<colorLog> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableLogs,
        columns: colorFields.values,
        where: '${colorFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return colorLog.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<colorLog>> readAll() async {
    final db = await instance.database;

    final orderBy = '${colorFields.createTime} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableLogs, orderBy: orderBy);

    return result.map((json) => colorLog.fromJson(json)).toList();
  }

  Future<List<colorLog>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${colorFields.createTime} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableLogs, orderBy: orderBy);

    return result.map((json) => colorLog.fromJson(json)).toList();
  }

  Future<int> update(colorLog color) async {
    final db = await instance.database;

    return db.update(
      tableLogs,
      color.toJson(),
      where: '${colorFields.id} = ?',
      whereArgs: [color.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableLogs,
      where: '${colorFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
