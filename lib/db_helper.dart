import 'package:database/student_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> setDatabase() async {
    var dbPath = await getDatabasesPath();
    String dbDirectory = join(dbPath, 'students.db');
    return await openDatabase(dbDirectory, version: 1, onCreate: _createDatabase);
  }

  static Future _createDatabase(Database database, int version) async {
    const dbTable = '''CREATE TABLE students(
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      course TEXT NOT NULL
    )''';
    await database.execute(dbTable);
  }

  static Future<int> createStudent(Student student) async {
    Database database = await DBHelper.setDatabase();
    return await database.insert('students', student.toJson());
  }

  static Future<List<Student>> readStudent() async {
    Database database = await DBHelper.setDatabase();
    var student = await database.query('students', orderBy: 'id DESC');
    List<Student> studentList = student.isNotEmpty
        ? student.map((details) => Student.fromJson(details)).toList()
        : [];
    return studentList;
  }

  static Future<int> updateStudent(Student student) async {
    Database database = await DBHelper.setDatabase();
    return await database.update('students', student.toJson(),
        where: 'id = ?', whereArgs: [student.id]);
  }

  static Future<int> deleteStudent(int id) async {
    Database database = await DBHelper.setDatabase();
    return await database.delete('students', where: 'id = ?', whereArgs: [id]);
  }
}