import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/subject_model.dart';

class SubjectDataBase {
  static final SubjectDataBase instance = SubjectDataBase._init();

  static Database? _database;

  SubjectDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('subjects.db');
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
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableSubjects ( 
  ${SubjectFields.subid} $idType, 
  ${SubjectFields.subname} $textType,
  ${SubjectFields.subcode} $textType,
  ${SubjectFields.totcls} $integerType,
  ${SubjectFields.totatd} $integerType,
  )
''');
  }

  Future<Subject> create(Subject subject) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableSubjects, subject.toJson());
    return subject.copy(id: id);
  }

  Future<Subject> readSub(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableSubjects,
      columns: SubjectFields.values,
      where: '${SubjectFields.subid} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Subject.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Subject>> readAllSubs() async {
    final db = await instance.database;

    // final orderBy = '${SubjectFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    // final result = await db.query(tableNotes, orderBy: orderBy);
    final result = await db.query(tableSubjects );

    return result.map((json) => Subject.fromJson(json)).toList();
  }

  Future<int> update(Subject subject) async {
    final db = await instance.database;

    return db.update(
      tableSubjects,
      subject.toJson(),
      where: '${SubjectFields.subid} = ?',
      whereArgs: [subject.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableSubjects,
      where: '${SubjectFields.subid} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
