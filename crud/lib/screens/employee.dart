import 'package:crud/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Empolyee",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.blueAccent),),
              Text("Form",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.orangeAccent),),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),),
            SizedBox(height: 10.0,),
            Container(

              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),

            ),
            SizedBox(height: 20.0,),
            Text("Age", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: TextField(
                controller: ageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),

            ),
            SizedBox(height: 20.0,),
            Text("Country", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: TextField(
                controller: countryController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),

            ),
            SizedBox(height: 20,),
            Center(child: ElevatedButton(onPressed: () async{
              String id = randomAlphaNumeric(10);
              Map<String, dynamic> employeeInfoMap = {
                "Name": nameController.text,
                "Age": ageController.text,
                "Id":id,
                "Country": countryController.text,
              };
              await DatabaseMethods().addEmployeeMethods(employeeInfoMap, id).then((value){
                Fluttertoast.showToast(
                    msg: "Employee value has been added successfully.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.teal,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              });

            }, child: Text("Add", style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),)))

          ],
        ),
      ),
    );
  }
}
