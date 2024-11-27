import 'package:blood_donation_app_flutter/util/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Modify the constructor to return a Future
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await OpenDB();
    return _database!;
  }

  Database? _database;

  Future<Database> OpenDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), "User.db"),
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
            '''
          CREATE TABLE usertable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            sex TEXT,
            weight REAL,
            height REAL,
            bloodGroup TEXT,
            lastDonated TEXT,
            phone TEXT,
            location TEXT
          )
          '''
        );
      },
    );
  }

  Future<int> insertUser(User user) async {
    final db = await database; // Ensure database is initialized
    return await db.insert("usertable", user.toMap());
  }

  Future<int> updateUser(User user) async {
    final db = await database; // Ensure database is initialized
    return await db.update(
      "usertable",
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(User user) async {
    final db = await database; // Ensure database is initialized
    return await db.delete(
      "usertable",
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<List<User>> getAllUsers() async {
    final db = await database; // Ensure database is initialized
    final List<Map<String, dynamic>> maps = await db.query("usertable");

    return List.generate(maps.length, (index) {
      return User(
        id: maps[index]["id"],
        name: maps[index]["name"],
        sex: maps[index]["sex"],
        weight: maps[index]["weight"],
        height: maps[index]["height"],
        bloodGroup: maps[index]["bloodGroup"],
        lastDonated: maps[index]["lastDonated"],
        phone: maps[index]["phone"],
        location: maps[index]["location"],
      );
    });
  }
}
