

import 'dart:convert';
import 'package:flutter/material.dart';
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
  List states;

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
          child: Center(),
        )
      ),
    );
  }
}
