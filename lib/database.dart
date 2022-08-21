import 'package:pharmchem/DataModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'MYDB.db'),
      onCreate: (database, version) async {
        await database.execute("""
          CREATE TABLE MyTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            image FILE NOT NULL,
            ScannedText TEXT NOT NULL
          )
          """);
      },
      version: 1,
    );
  }

  Future<bool> insertData(Prescription prescription) async {
    final Database db = await initDB();
    db.insert("MyTable", prescription.toMap());
    return true;
  }
}
