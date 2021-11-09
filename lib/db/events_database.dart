import 'package:sqflite/sqflite.dart';
import 'package:vhelp_test/model/event.dart';
import 'package:path/path.dart';

class EventsDatabase {
  static final EventsDatabase instance = EventsDatabase._init();

  static Database? _database;

  EventsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('events.db');
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
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE $tableLogs (
      ${eventFields.id} $idType,
      ${eventFields.title} $textType,
      ${eventFields.description} $textType,
      ${eventFields.from} $textType,
      ${eventFields.to} $textType,
      ${eventFields.backgroundColor} $textType,
      ${eventFields.isAllDay} $boolType
    )
    ''');
  }

  Future<Event> create(Event event) async {
    final db = await instance.database;

    final id = await db.insert(tableLogs, event.toJson());
    return event.copy(id: id);
  }

  Future<Event> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableLogs,
        columns: eventFields.values,
        where: '${eventFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Event.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> update(Event color) async {
    final db = await instance.database;

    return db.update(
      tableLogs,
      color.toJson(),
      where: '${eventFields.id} = ?',
      whereArgs: [color.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableLogs,
      where: '${eventFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
