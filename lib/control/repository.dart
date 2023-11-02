import 'package:grid_notes/model/Model.dart';
import 'package:sqflite/sqflite.dart';
import 'DB_Connetion.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }
  static var _database;
  get getDB async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();

      return _database;
    }
  }

  //Read all

  reporeadAll(table) async {
    var connection = await getDB;

    return await connection.query(table);
    // await _database.query
  }

  //read one

  reporReadOne(table, data) async {
    var connection = await getDB;

    return await connection
        .rawQuery('select * from $table where id = ?', [data]);
  }

//Insert
  repoinsertData(table, UserModel inputTable) async {
    var connection = await getDB;
    return await connection.insert(table, inputTable.userType());
  }

//delete

  Future<dynamic> repoDelete(table, id) async {
    var connection = await getDB;
    return await connection.rawDelete('delete from $table where id = ?', [id]);
  }


  Future<dynamic> repoUpdate(table, data) async {
    var connection = await getDB;

    // Extract the necessary fields for the update
    String title = data['title'] ?? '';
    String note = data['note'] ?? '';

    // Perform the update operation using the extracted fields
    return await connection.update(
      table,
      {'title': title, 'note': note},
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }
}
