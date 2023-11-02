import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  setDatabase() async {
    var getDirectory = await getApplicationDocumentsDirectory();
    var path = await join(getDirectory.path, 'notes.db');
    var database = await openDatabase(
      path,
      version: 5,
      onCreate: _createDB,
    );

    if (database.isOpen) {
      print('Database connection established successfully!');
    } else {
      print('Failed to establish database connection.');
    }
    return database;
  }

  Future<void>? _createDB(Database database, int version) async {
    String? sql =
        'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title Text, note text)';

    return await database.execute(sql);
  }


}
