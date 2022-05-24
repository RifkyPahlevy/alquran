import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  DatabaseManager._private();
  static DatabaseManager instance = DatabaseManager._private();

  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDatabase();
    }
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final String path = await getDatabasesPath();
    final String dbPath = join(path, 'bookmark.db');
    final Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE bookmark(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        surah TEXT NOT NULL,
        ayat INTEGER NOT NULL,
        juz INTEGER NOT NULL,
        via TEXT NOT NULL,
        index_ayat INTEGER NOT NULL,
        last_read INTEGER NOT NULL DEFAULT 0
        
        )
        ''');
    });
    return database;
  }
}
