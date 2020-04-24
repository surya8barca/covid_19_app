import 'package:covid_19/states.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map info;
  int active, confirmed, recovered, deaths;

  Future<void> india() async {
    final data = await get('https://covid19indiaapi.herokuapp.com/v1/overall');
    info = jsonDecode(data.body);
    setState(() {
      confirmed = info["Confirmed"];
      recovered = info["Recovered"];
      deaths = info["Death"];
      active = confirmed - deaths - recovered;
    });
  }

  @override
  void initState() {
    super.initState();
    india();
  }

  @override
  Widget build(BuildContext context) {
    if ((confirmed == null)) {
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
          backgroundColor: Colors.lightBlueAccent,
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.bdpinternational.com/uploads/attachments/ck6axr5izcptnksqp75lnejn5-update-images4.0.130.2500.1406.max.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'India\'s Covid-19',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white60,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Statistics',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        color: Colors.blue,
                        thickness: 3,
                        indent: 20,
                        endIndent: 20,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Total : $confirmed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Active: $active',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Recovered: $recovered',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Deaths: $deaths',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
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
                      Text('Source: Ministry of Health and Family Welfare',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Click below for\nState-wise Statistics',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.cyan,
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          Route route =
                              MaterialPageRoute(builder: (context) => States());
                          Navigator.push(context, route);
                        },
                        child: Text(
                          'State-wise Statistics',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
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
          ),
        ),
      );
    }
  }
}
