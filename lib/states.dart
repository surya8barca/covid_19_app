import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid_19/selectedstate.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MaterialApp(home: States()));

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
    info = jsonDecode(data.body);
    setState(() {
      states = info.keys.toList();
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
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'COVID-19 TRACKER',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.red),
              ),
              Text(
                'INDIA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.blue,
                ),
              ),
              SpinKitPumpingHeart(
                color: Colors.red,
                size: 150.0,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text(
            'Covid-19',
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://www.bdpinternational.com/uploads/attachments/ck6axr5izcptnksqp75lnejn5-update-images4.0.130.2500.1406.max.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Select the State you want to Enquire about',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.cyan,
                      ),
                      child: DropdownButton(
                        iconEnabledColor: Colors.black,
                        underline: Container(),
                        hint: Text(
                          'Select State:',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        isExpanded: true,
                        items: states.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            value: value,
                          );
                        }).toList(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (chosen) {
                          setState(() {
                            stateSelected = chosen;
                          });
                        },
                        value: stateSelected,
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      padding: EdgeInsets.all(10),
                      color: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: Colors.black,
                            width: 3,
                          )),
                      onPressed: () {
                        if (stateSelected == null) {
                          Alert(
                                  context: context,
                                  title: 'Empty Field',
                                  desc: 'Please Select a State',
                                  buttons: [],
                                  style: AlertStyle(
                                      backgroundColor: Colors.transparent,
                                      titleStyle: TextStyle(
                                          color: Colors.red,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                      descStyle: TextStyle(
                                          color: Colors.white, fontSize: 25)))
                              .show();
                        } else {
                          Route route = MaterialPageRoute(
                              builder: (context) => Selectedstate(
                                  info: info, state: stateSelected));
                          Navigator.push(context, route);
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Divider(
                color: Colors.blue,
                thickness: 3,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Quick Links',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.blue,
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                              color: Colors.red,
                              width: 3,
                              style: BorderStyle.solid)),
                      color: Colors.black,
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) =>
                                Selectedstate(info: info, state: 'Delhi'));
                        Navigator.push(context, route);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Delhi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                              color: Colors.red,
                              width: 3,
                              style: BorderStyle.solid)),
                      color: Colors.black,
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => Selectedstate(
                                info: info, state: 'Maharashtra'));
                        Navigator.push(context, route);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.directions_transit,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Maharashtra',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                              color: Colors.red,
                              width: 3,
                              style: BorderStyle.solid)),
                      color: Colors.black,
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) =>
                                Selectedstate(info: info, state: 'Punjab'));
                        Navigator.push(context, route);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.terrain,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Punjab',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                              color: Colors.red,
                              width: 3,
                              style: BorderStyle.solid)),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'India',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.blue,
                      thickness: 3,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(
                color: Colors.black,
                thickness: 3,
                indent: 10,
                endIndent: 10,
              ),
              Text('"Stay At Home, Stay Safe"',
                  style: TextStyle(
                      fontSize: 29,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold)),
              Divider(
                color: Colors.black,
                thickness: 3,
                indent: 10,
                endIndent: 10,
              ),
            ],
          ),
        )),
      );
    }
  }
}
