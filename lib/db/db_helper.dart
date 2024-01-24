import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timetable_proj/models/task.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 3;
  static final String _tableName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = join(await getDatabasesPath(), 'tasks.db');
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          _createTable(db);
        },
        onUpgrade: (db, oldVersion, newVersion) {
          _upgradeTable(db, oldVersion, newVersion);
        },
      );
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  static void _createTable(Database db) {
    print('Creating a new database');
    db.execute('CREATE TABLE IF NOT EXISTS $_tableName('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title STRING, date TEXT,'
        'startTime STRING, endTime STRING,'
        'color INTEGER,'
        'isCompleted INTEGER)');
  }

  static void _upgradeTable(Database db, int oldVersion, int newVersion) {
    print('Upgrading database from $oldVersion to $newVersion');
    db.execute('DROP TABLE IF EXISTS $_tableName');
    _createTable(db);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    if (_db == null) {
      await initDb();
    }
    return _db!.query(_tableName);
  }

  static Future<int> insert(Task? task) async {
    print('Inserting task: ${task?.toJson()}');
    try {
      int result = await _db?.insert(_tableName, task!.toJson()) ?? 1;
      print('Inserted task with ID: $result');
      return result;
    } catch (e) {
      print('Error inserting task: $e');
      return 0;
    }
  }
}