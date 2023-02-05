import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ssjapp1/models/subject_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'subjects.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE subjects (
      id INTEGER PRIMARY KEY,
      name TEXT,
      quantity INTEGER
    )
    ''');
  }

  Future<List<Subject>> getSubjects() async{
    Database db = await instance.database;
    var subjects = await db.query('subjects',orderBy: 'name');
    List<Subject> subList = subjects.isNotEmpty 
    ? subjects.map((json) => Subject.fromMap(json)).toList()
    : [];
    return subList;
  }

  Future<int> add(Subject subject) async{
    Database db = await instance.database;
    return await db.insert('subjects', subject.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('subjects', where: 'id=?',whereArgs: [id]);
  }

  Future<int> update(Subject subject) async {
    Database db = await instance.database;
    return await db.update('subjects', subject.toMap(),where: 'id=?',whereArgs: [subject.id]);
  }



}
