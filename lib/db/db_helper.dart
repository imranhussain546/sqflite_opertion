import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_opertion/db/db_const.dart';
import 'package:sqflite_opertion/model/department.dart';
import 'package:sqflite_opertion/model/employee.dart';
import 'package:sqflite_opertion/model/employee_dtl.dart';
class DbHelper{
  static final DbHelper instance = DbHelper._init();
  static Database? _database;
  DbHelper._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('Industry.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integer = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE ${DbConst.tableDep} (
        ${DbConst.depId} $integer, 
        ${DbConst.depName} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE ${DbConst.tableEmp} (
        ${DbConst.empId} $idType, 
        ${DbConst.empName} $textType,
        ${DbConst.depId} $integer,
        FOREIGN KEY (${DbConst.depId}) REFERENCES ${DbConst.tableDep} (${DbConst.depId})
      )
    ''');
  }

  Future<Employee> createEmployee(Employee note) async {
    final db = await instance.database;

    final id = await db.insert(DbConst.tableEmp, note.toJson());
    return note;
  }
  Future<Department> createDep(Department note) async {
    final db = await instance.database;

    final id = await db.insert(DbConst.tableDep, note.toJson());
    return note;
  }

  Future<List<EmployeeDtl>> readAllEmployeeDetails() async {
    final db = await instance.database;

    String sql = '''
      SELECT ${DbConst.tableEmp}.${DbConst.empName} AS ${DbConst.empName}, 
             ${DbConst.tableDep}.${DbConst.depName} AS ${DbConst.depName}
      FROM ${DbConst.tableEmp} 
      JOIN ${DbConst.tableDep} ON ${DbConst.tableEmp}.${DbConst.depId} = ${DbConst.tableDep}.${DbConst.depId}
    ''';

    final result = await db.rawQuery(sql);

    return result.map((json) => EmployeeDtl.fromJson(json)).toList();
  }
}