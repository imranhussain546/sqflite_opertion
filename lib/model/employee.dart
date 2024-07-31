import 'package:sqflite_opertion/db/db_const.dart';

class Employee{
  final int? employeeId;
  final String employeeName;
  final int depertmentId;
  Employee({this.employeeId,required this.employeeName, required this.depertmentId});

  Map<String, Object?> toJson() => {
    DbConst.empId: employeeId,
    DbConst.empName: employeeName,
    DbConst.depId: depertmentId,

  };
}