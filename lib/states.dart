

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

void main() => runApp(MaterialApp(
  home:States()
)
);

class States extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<States> {
  
  Map info;
  List<String> states;
  String stateSelected;

  Future<void> stateData() async {
    final data = await get('https://covid19indiaapi.herokuapp.com/v1/states');
    info =jsonDecode(data.body);
    setState(() {
      states=info.keys.toList();
    });
    print(states);   
  }

  @override
  void initState() {
    super.initState();
    stateData();
  }
  @override
  Widget build(BuildContext context) {
  if ((info == null)) {
      return Scaffold(
            backgroundColor: Colors.lightBlue,
            body: Center(
              child: SpinKitHourGlass(
                color: Colors.red,
                size: 200.0,
              ),
            ),
          );
    } else {
      return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          'Covid-19 Tracker',
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.all(10),
          child: DropdownButton(
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down_circle),
            iconEnabledColor: Colors.black,
            iconSize: 50,
            isDense: true,
            hint: Text(
              'Select State ->',
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
            items: states.map<DropdownMenuItem<String>>((value){
              return DropdownMenuItem<String>(
                child: Text(value),
                value: value,
              );
            }).toList(),
            style: TextStyle(
              color:Colors.black,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (chosen){
              setState(() {
                stateSelected=chosen;   
              });
              print(stateSelected);
            },
            value: stateSelected,
          ),
        )
      ),
    );
    }
  }
}
