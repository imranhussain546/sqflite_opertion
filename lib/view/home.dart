import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sqflite_opertion/db/db_helper.dart';
import 'package:sqflite_opertion/model/department.dart';
import 'package:sqflite_opertion/model/employee.dart';
import 'package:sqflite_opertion/model/employee_dtl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController depId = TextEditingController();
  TextEditingController depName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child: Column(
            children: [
              Text('Employee Details'),
              SizedBox(height: 10,),
              TextFormField(
                controller:name ,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller:depId ,
              ),
              SizedBox(height: 10,),

              ElevatedButton(onPressed: () async {
               var empData= Employee(employeeName:name.text,depertmentId: int.parse(depId.text) );
                await DbHelper.instance.createEmployee(empData);
              }, child: Text('submit')),

              Text('Department Details'),

              SizedBox(height: 10,),
              TextFormField(
                controller:depId ,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller:depName ,
              ),
              ElevatedButton(onPressed: () async {
                var empData= Department(depId: int.parse(depId.text),depName:depName.text );
                await DbHelper.instance.createDep(empData);
              }, child: Text('submit')),

              ElevatedButton(onPressed: () async {
                List<EmployeeDtl> data=await DbHelper.instance.readAllEmployeeDetails();
                print('datata ${data[0].employeeName}');
                print('datata ${data[0].depertmentName}');
              }, child: Text('submit')),
            ],
          ),
        ),
      ),

    );
  }
}
