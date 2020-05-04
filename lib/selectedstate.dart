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
    if (key != null) {
      setState(() {
        infolatest = stateinfo[key];
      });
    }
    if (key != null) {
      getDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Covid-19',
          style: TextStyle(
            fontSize: 40.0,
            color: Colors.black,
          ),
        ),
      ),
      body: (key == null)
          ? SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/back.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Covid-19 Updates',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.state}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.blue,
                        thickness: 3,
                        indent: 20,
                        endIndent: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'Sorry!!\nThe Data is not Available\nPlease try after some time!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 2),
                        ),
                        color: Colors.cyan,
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Check for Another State',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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
            )
          : SingleChildScrollView(
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Covid-19 Updates',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.state}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.blue,
                        thickness: 3,
                        indent: 20,
                        endIndent: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5),
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
                              'Total : $total',
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
                            Text(
                                'Source: Ministry of Health and Family Welfare',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(width: 2),
                        ),
                        color: Colors.cyan,
                        padding: EdgeInsets.all(10),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Check for Another State',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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
            ),
    );
  }
}
