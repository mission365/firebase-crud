import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DatabaseMethods{

  ///Create
  Future addEmployeeMethods(Map<String, dynamic> employeeInfoMap, String id) async{
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }

  ///Read
  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }


  ///Update
  Future updateEmployeeDetails(Map<String, dynamic> updateInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .update(updateInfoMap);
  }

  ///Delete
  Future deleteEmployeeDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .delete();
  }
}