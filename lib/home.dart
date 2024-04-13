import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages

// ignore: depend_on_referenced_packages
// import 'package:intl/int?
import 'package:path/path.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinput2 = TextEditingController();
  TextEditingController OK = TextEditingController();
  String formattedDate = '';
  String? _email;
  var datename;
  int diff = 0;
  int diff2 = 0;
  int diff3 = 0;
  int diff4 = 0;
  int diff5 = 0;
  // bool nn = false;
  var date2;
  // String nn = '';

  void calc() {
    if (datename != null) {
      // print(
      //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
      DateTime formattedDate = datename;
      var dat = DateTime.now();

      var m = (10, formattedDate.toString().length);

      print("CURRENT DATE$dat");

      diff4 = dat.difference(datename).inMinutes;

      diff3 = dat.difference(datename).inHours;
      diff = dat.difference(datename).inDays ~/ 365;
      diff5 = dat.difference(datename).inDays;

      setState(() {});
      print(" user dob$formattedDate");

      // String ok = formattedDate.toString();
      print("result$diff");
    } else {
      print("Date is not selected");
    }
  }

  String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return 'PLEASE ENTER DOB';
    } else {
      return null;
    }
  }

  String? validateMobil(String? value) {
    if (value!.isEmpty) {
      return 'PLEASE ENTER CURRENT DATE';
    } else {
      return null;
    }
  }

  List taskList = [];
  DbManager dbHelper = DbManager();
  void _refreshTaskList() async {
    List taskList = await dbHelper.getModelList();
    print("task...$taskList");
  }

  @override
  void initState() {
    _refreshTaskList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: const Color.fromRGBO(255, 255, 255, 1),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(600),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Color.fromARGB(255, 158, 168, 228),
                  Colors.white,
                  Color(0xff0b81ff),
                ],
              ),
            ),
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Container(),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      // decoration: ,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            color: Color.fromARGB(255, 205, 220, 255),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            offset: Offset(0, 0),
                            color: Color.fromARGB(255, 54, 98, 244),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            offset: Offset(0, 0),
                            color: Color.fromARGB(234, 90, 100, 121),
                            blurRadius: 10.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.deepPurpleAccent[400],
                        border: Border(
                            left: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            top: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                            right: BorderSide(color: Colors.white, width: 3)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 15, top: 15),
                        child: Column(
                          children: [
                            Row(children: [
                              Text(
                                "Enter your DOB:",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                            Container(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, bottom: 15, top: 15),
                                  child: Center(
                                      child: TextFormField(
                                    cursorErrorColor: Colors.white,
                                    onSaved: (String? val) {
                                      _email = val;
                                    },
                                    validator: validateMobile,
                                    controller: dateinput,
                                    decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.white),
                                        // contentPadding:,
                                        // const EdgeInsets.symmetric(
                                        //     vertical: 17.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        icon: Icon(
                                          Icons.calendar_month_rounded,
                                          color: Colors.white,
                                          size: 34,
                                        ),
                                        hintText: "ENTER DOB",
                                        hintStyle: const TextStyle()),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1980),
                                              lastDate: DateTime(2101));
                                      datename = pickedDate;
                                      print("date$datename");

                                      setState(() {
                                        dateinput.text = datename.toString();
                                      });
                                    },
                                  ))),
                            ),
                            // Row(
                            //   children: [
                            //     Container(
                            //       padding: EdgeInsets.only(bottom: 15),
                            //       child: Text(
                            //         "Today Date       :",
                            //         style: TextStyle(
                            //             fontSize: 20, color: Colors.white),
                            //       ),
                            //     ),
                            //     // SizedBox(
                            //     //   height: 300,
                            //     // ),

                            //     Expanded(
                            //       child: Container(
                            //           decoration: BoxDecoration(),
                            //           padding:
                            //               EdgeInsets.only(left: 8, bottom: 20),
                            //           child: Center(
                            //               child: Container(
                            //             padding: EdgeInsets.only(right: 5),
                            //             child: TextFormField(
                            //               onSaved: (String? val) {
                            //                 _email = val;
                            //               },
                            //               validator: validateMobil,
                            //               controller: dateinput2,
                            //               decoration: InputDecoration(
                            //                   errorStyle:
                            //                       TextStyle(color: Colors.white),
                            //                   contentPadding:
                            //                       const EdgeInsets.symmetric(
                            //                           vertical: 17.0),
                            //                   border: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(15.0),
                            //                     borderSide: BorderSide.none,
                            //                   ),
                            //                   fillColor: Colors.white,
                            //                   filled: true,
                            //                   icon: Icon(Icons.calendar_today),
                            //                   hintText: "TODAY'S DATE",
                            //                   hintStyle: TextStyle()),
                            //               readOnly:
                            //                   true, //set it true, so that user will not able to edit text
                            //               onTap: () async {
                            //                 DateTime? pickedDate =
                            //                     await showDatePicker(
                            //                         context: context,
                            //                         initialDate: DateTime.now(),
                            //                         firstDate: DateTime(2000),
                            //                         lastDate: DateTime(2101));
                            //                 date2 = pickedDate;
                            //                 print("date$da");
                            //                 setState(() {
                            //                   dateinput2.text = date2.toString();
                            //                 });
                            //               },
                            //             ),
                            //           ))),
                            //     ),
                            //   ],
                            // ),

                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border(
                                  left:
                                      BorderSide(width: 3, color: Colors.white),
                                ),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    // final dat = DateTime.now();
                                    // final diff = dat.difference(formattedDat);
                                    // print("bbb$diff");
                                    // calc();

                                    //

                                    if (_formKey.currentState!.validate()) {
                                      _refreshTaskList();
                                      DbManager DB = DbManager();
                                      var rng = Random().nextInt(200);
                                      DB.insertModel(
                                          Model(id: rng, diff: diff));

                                      calc();
                                      print("SUCEES");
                                    }
                                  },
                                  child: Text(
                                    "calculate",
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Container(
                              // ignore: unnecessary_null_comparison
                              child: diff == 0
                                  ? Container(
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    )
                                  : Text(
                                      "age :$diff",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        "OTHER DETAIL",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Ralewa'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromARGB(255, 247, 242, 242),
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  right: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  top: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                ),
                              ),
                              height: 70,
                              width: 320,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                    Text(
                                      "total no of days: $diff5",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              height: 70,
                              width: 320,
                              margin: EdgeInsets.only(left: 4, right: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromARGB(255, 247, 242, 242),
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  right: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  top: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.hourglass_empty,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                    Text(
                                      "total no of hrs: $diff3",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 4, right: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Color.fromARGB(255, 247, 242, 242),
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  right: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  top: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                ),
                              ),
                              height: 70,
                              width: 320,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                    Text(
                                      "total no of min: $diff4",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                              width: 200,
                              height: 100,
                              child: ListView.builder(
                                  itemCount: taskList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      child: ListTile(
                                        title: Text(taskList[index].diff),
                                        subtitle: Text("description:"),
                                        trailing: IconButton(
                                            onPressed: () async {
                                              // print("del$del");
                                              // setState(() {});

                                              // setState(() {});
                                            },
                                            icon: const Icon(Icons.delete,
                                                color: Colors.white)),
                                      ),
                                    );
                                  }))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DbManager {
  Database? _database;

  Future openDb() async {
    print("DDDDD..");
    _database = await openDatabase(join(await getDatabasesPath(), "ss.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE model(id INTEGER PRIMARY KEY autoincrement, name INTEGER)",
      );
    });
    return _database;
  }

  Future insertModel(Model model) async {
    await openDb();
    print("NNNN");
    return await _database?.insert('model', model.toMap()) ?? 0;
  }

  Future<List> getModelList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('model');

    return List.generate(maps.length, (i) {
      print("model");
      return Model(
        id: maps[i]['id'],
        diff: maps[i]['diff'],
      );
    });

    // return maps
    //     .map((e) => Model(
    //         id: e["id"], fruitName: e["fruitName"], quantity: e["quantity"]))
    //     .toList();
  }

  // Future<int> updateModel(Model model) async {
  //   await openDb();
  //   return await _database!.update('model', model.toJson(),
  //       where: "id = ?", whereArgs: [model.id]);
  // }

  Future<void> deleteModel(Model model) async {
    await openDb();
    await _database!.delete('model', where: "id = ?", whereArgs: [model.id]);
  }
}

class Model {
  final int id;
  final int diff;

  Model({
    required this.id,
    required this.diff,
  });

  Model.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        diff = result["name"];

  Map<String, dynamic> toMap() {
    // ignore: pre

    var map = <String, dynamic>{};

    // map['mm'] = mm;
    map['diff'] = diff;
    map['id'] = id;

    return map;
  }
}
