import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/screens/employee.dart';
import 'package:crud/services/database.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

  Stream? EmployeeStream;

  getOnTheLoad() async{
    EmployeeStream = await DatabaseMethods().getEmployeeDetails();

    setState(() {

    });
  }
  void initState(){
    getOnTheLoad();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(stream: EmployeeStream, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
          ? ListView.builder(
        itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
          DocumentSnapshot ds = snapshot.data.docs[index];
          return Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name : " + ds["Name"],
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        GestureDetector(
                          onTap: (){
                            nameController.text = ds["Name"];
                            ageController.text = ds["Age"];
                            countryController.text = ds["Country"];
                            EditEmployeeDetails(ds["Id"]);
                          },
                            child: Icon(Icons.edit, color: Colors.orangeAccent,))
                      ],
                    ),
                    Text(
                      "Age : " + ds["Age"],
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Country : " + ds["Country"],
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        GestureDetector(
                            onTap: () async{
                              await DatabaseMethods().deleteEmployeeDetails(ds["Id"]);
                            },
                            child: Icon(Icons.delete, color: Colors.orangeAccent,))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
          })
          : Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Employee()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Futter",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.blueAccent),
              ),
              Text(
                "Firebase",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.orangeAccent),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }

  Future EditEmployeeDetails(String id) => showDialog(context: context, builder: (context) => AlertDialog(
    content: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: Icon(Icons.cancel)),
              SizedBox(width: 30.0,),
              Text(
                "Edit",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.blueAccent),
              ),
              Text(
                "Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.orangeAccent),
              ),
            ],
          ),
          Text("Name", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),),
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
          Text("Age", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),),
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
          Text("Country", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),),
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
          SizedBox(height: 20.0,),
          Center(child: ElevatedButton(onPressed: () async{
            Map<String, dynamic> updateInfoMap = {
              "Name" :nameController.text,
              "Age" : ageController.text,
              "Country" : countryController.text,
              "Id" : id,
            };

            await DatabaseMethods().updateEmployeeDetails(updateInfoMap, id).then((value){
              Navigator.pop(context);
            });
          }, child: Text("Update")))
        ],
      ),
    ),
  ));

}
