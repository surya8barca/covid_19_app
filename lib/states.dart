

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid_19/selectedstate.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                underline: Container(),
                icon: Icon(Icons.arrow_drop_down_circle),
                iconEnabledColor: Colors.black,
                iconSize: 50,
                hint: Text(
                  'Select State ->',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
                items: states.map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem<String>(
                    child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),),
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
                },
                value: stateSelected,
              ),
              SizedBox(height:30),
              RaisedButton(
                color: Colors.black,
                onPressed: (){
                  if(stateSelected==null)
                  {
                    Alert(context: context, title: 'No State Selected',desc: 'Please Select a State',buttons: [],style: AlertStyle(backgroundColor: Colors.cyan)).show();
                  }
                  else
                  {
                    Route route = MaterialPageRoute(builder: (context) => Selectedstate(info:info,state:stateSelected));
                    Navigator.push(context, route);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.done,
                      color: Colors.blue,
                      size: 60,
                      ),
                    SizedBox(width: 10,),
                    Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                ),
                SizedBox(height: 10,),
                Divider(
                  color: Colors.black,
                  thickness: 5,
                ),
                SizedBox(height: 10,),
                Text(
                  'Quick Links',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ), 
                ),
                SizedBox(height: 10,),
                RaisedButton(
                color: Colors.black,
                onPressed: (){
                  Route route = MaterialPageRoute(builder: (context) => Selectedstate(info:info,state:'Delhi'));
                    Navigator.push(context, route);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      color: Colors.blue,
                      size: 60,
                      ),
                    SizedBox(width: 10,),
                    Text(
                      'Delhi',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                ),
                SizedBox(height: 10,),
                RaisedButton(
                color: Colors.black,
                onPressed: (){
                  Route route = MaterialPageRoute(builder: (context) => Selectedstate(info:info,state:'Maharashtra'));
                    Navigator.push(context, route);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.directions_transit,
                      color: Colors.blue,
                      size: 60,
                      ),
                    SizedBox(width: 10,),
                    Text(
                      'Maharashtra',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                ),
                SizedBox(height: 10,),
                RaisedButton(
                color: Colors.black,
                onPressed: (){
                  Route route = MaterialPageRoute(builder: (context) => Selectedstate(info:info,state:'Punjab'));
                    Navigator.push(context, route);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.terrain,
                      color: Colors.blue,
                      size: 60,
                      ),
                    SizedBox(width: 10,),
                    Text(
                      'Punjab',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                ),
                SizedBox(height: 30,),
                RaisedButton(
                color: Colors.black,
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: Colors.blue,
                      size: 60,
                      ),
                    SizedBox(width: 10,),
                    Text(
                      'India',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                ),
            ],
          ),
        )
      ),
    );
    }
  }
}
