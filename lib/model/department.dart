import 'package:sqflite_opertion/db/db_const.dart';

class Department{
  final int? depId;
  final String depName;

  Department({this.depId,required this.depName,});

  Map<String, Object?> toJson() => {
    DbConst.depId: depId,
    DbConst.depName: depName,
  };
}