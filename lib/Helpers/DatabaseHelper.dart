
import 'dart:async';

import 'package:mizomade/models/CategoryDBModel.dart';
import 'package:mizomade/utils/Network.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

   Database db;
  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'mizomade.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE category (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL UNIQUE ,
              color TEXT NOT NULL,
              unique (id, name)
            )
          """,
        );
      },
      version: 1,
    );
  }


  Future<int> insertCategory(CategoryDBModel category) async {
    int result = await db.insert('category', category.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future insertCategoryList() async {
    CategoryDBModel category;

    List cats = await categoryList();
    for (var c in cats) {
      // do something
      print(c['id']);
      category = new CategoryDBModel(id: c['id'],name: c['name'],color: c['color']);
      await db.insert('category', category.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }


  }


  Future<int> updateCategory(CategoryDBModel category) async {
    int result = await db.update(
      'category',
      category.toMap(),
      where: "id = ?",
      whereArgs: [category.id],
    );
    return result;
  }

  Future<List<CategoryDBModel>> retrieveCategories() async {
    final List<Map<String, Object>> queryResult = await db.query('category');
    return queryResult.map((e) => CategoryDBModel.fromMap(e)).toList();
  }

  Future<void> deleteCategory(int id) async {
    await db.delete(
      'category',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteDatabase()async{
    String path = await getDatabasesPath();
    databaseFactory.deleteDatabase('mizomade.db');
  }


}