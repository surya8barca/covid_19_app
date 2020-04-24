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
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: SpinKitPumpingHeart(
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
        body: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'India\'s Covid-19 Updates',
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Total Cases:$confirmed',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              Text(
                'Active:$active',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              Text(
                'Recovered:$recovered',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              Text(
                'Deaths:$deaths',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
              RaisedButton(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (context) => States());
                  Navigator.push(context, route);
                },
                child: Text('State-wise Analysis'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
