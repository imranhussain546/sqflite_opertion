import 'package:sqflite_opertion/db/db_const.dart';

class EmployeeDtl{
  final String employeeName;
  final String depertmentName;
  EmployeeDtl({required this.employeeName,required this.depertmentName,});

  static EmployeeDtl fromJson(Map<String, Object?> json) => EmployeeDtl(
    employeeName: json[DbConst.empName] as String,
    depertmentName: json[DbConst.depName] as String,

  );
}