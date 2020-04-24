import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Selectedstate(),
    ));

class Selectedstate extends StatefulWidget {
  final Map info;
  final String state;
  Selectedstate({this.info, this.state});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Selectedstate> {
  Map stateinfo;
  List infolatest;
  String key;
  int total, active, deaths, recovered;
  getKey() {
    List date = DateTime.now().toString().split(' ')[0].toString().split('-');
    String today = "${date[2]}/${date[1]}/${date[0]}";
    String yesterday = "${int.parse(date[2]) - 1}/${date[1]}/${date[0]}";
    if (stateinfo.keys.toList().any((e) => e.contains(today)) == true) {
      setState(() {
        key = today;
      });
    } else if (stateinfo.keys.toList().any((e) => e.contains(yesterday)) ==
        true) {
      setState(() {
        key = yesterday;
      });
    } else {
      key = null;
    }
  }

  getDetails() {
    setState(() {
      total = infolatest[0] + infolatest[1];
      recovered = infolatest[2];
      deaths = infolatest[3];
      active = total - recovered - deaths;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      stateinfo = widget.info[widget.state];
    });
    getKey();
    print(key);
    print(stateinfo.keys);
    if (key != null) {
      setState(() {
        infolatest = stateinfo[key];
      });
    }
    print(infolatest.toString());
    if (key != null) {
      getDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          widget.state,
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.black,
          ),
        ),
      ),
      body: (key == null)
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        '${widget.state}\'s Covid-19 Updates',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sorry!!\nThe Data is not updated yet\nPlease try after some time!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${widget.state}\'s Covid-19 Updates',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total Cases:$total',
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
                      Navigator.pop(context);
                    },
                    child: Text('Check Another State'),
                  ),
                ],
              ),
            ),
    );
  }
}
