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

  get datetime => null;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableLog(
      ${TimeStampFields.id} $idType,
      ${TimeStampFields.datetime} $textType,
    )
    ''');
  }

  Future<TimeStampDetails> create(TimeStampDetails timeStamp) async {
    final db = await instance.database;
    /* final json = TimeStampDetails.toJson();
    final columns = '${TimeStampFields.datetime}';
    final values = '${json[TimeStampFields.datetime]}';
    final id = await db
        .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');*/
    final id = await db.insert(tableLog, timeStamp.toJson());
    return timeStamp.copy(id: id);
  }

  /*Future<TimeStampDetails> readLog(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableLog,
      columns: TimeStampFields.values,
      where: '${TimeStampFields.id}= ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return TimeStampDetails.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }*/

  Future<List<TimeStampDetails>> readAllLog() async {
    final db = await instance.database;
    final orderBy = '${TimeStampFields.datetime} ASC';
    /*final result =
        await db.rawQuery('SELECT * FROM $tableLog ORDER BY $orderBy');*/
    final result = await db.query(tableLog, orderBy: orderBy);

    return result.map((json) => TimeStampDetails.fromJson(json)).toList();
  }

  /*Future<int> update(TimeStampDetails TimeStampDetails) async {
    final db = await instance.database;
    return db.update(
      tableLog,
      TimeStampDetails.toJson(),
      where: '${TimeStampFields.id}=?',
      whereArgs: [TimeStampDetails.id],
    );
  }*/

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
