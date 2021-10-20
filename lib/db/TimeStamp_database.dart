import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vhelp_test/model/TimeStampLog.dart';

class TimeStampLog {
  static final TimeStampLog instance = TimeStampLog._init();
  static Database? _database;
  TimeStampLog._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('timestampDatabase.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableLog(
      ${TimeStampFields.id} $idType,
      ${TimeStampFields.datetime} $textType
    )
    ''');
  }

  Future<TimeStampDetails> create(TimeStampDetails timeStamp) async {
    final db = await instance.database;
    final id = await db.insert(tableLog, timeStamp.toJson());
    return timeStamp.copy(id: id);
  }

  Future<List<TimeStampDetails>> readAllLog() async {
    final db = await instance.database;
    final orderBy = '${TimeStampFields.datetime} ASC';
    /*final result =
        await db.rawQuery('SELECT * FROM $tableLog ORDER BY $orderBy');*/
    final result = await db.query(tableLog, orderBy: orderBy);

    return result.map((json) => TimeStampDetails.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
