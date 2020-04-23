

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Selectedstate(),
)
);

class Selectedstate extends StatefulWidget {
  final Map info;
  final String state;
  Selectedstate({this.info,this.state});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Selectedstate> {

  @override
  void initState() {
    super.initState();
    print(widget.info[widget.state]);
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
    );
  }
}
