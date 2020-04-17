import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Galeria extends StatefulWidget {
  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  var _title;
  var _content;
  var _photo;
  var _count = [];
  var _id = "2";
  var _index= 1;


  Future<String> getBeacons() async {
    String url = 'http://192.168.15.15:3000/beacons/';
    final response = 
    await http.get(url + '$_id');


    var data = json.decode(response.body);
    setState(() {
      _title = data['content_name'];
      _content = data['content_description'];
      _photo = data['content'];
    });

    var secondResponse = await http.get(url);
    var data2 = json.decode(secondResponse.body);

    for (var i = 0; i < data2.length; i++) {
      _count.add(data2[i]['id']);
    }

    _id = _count[_index];
    _index++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 100,
        width: 100,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              getBeacons();
              }, 
              backgroundColor: Colors.orangeAccent,
              child: Icon(Icons.search),
              )
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.amber[300],
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.only(top: 18),
            child:
              Image.network(
                  _photo,
                  width: 400,
                  height: 300,
                  fit: BoxFit.fitWidth,
              ),
          ), 
          SizedBox(height: 40.0),
          Container(
           margin: const EdgeInsets.only(top:25, left: 32, right: 32),
           decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
           child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  _title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  _content,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ]
          ),
        )
        ]
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.grey[200],
        margin: EdgeInsets.only(top: 10),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton(
            child: Icon(
              Icons.home, 
              color: Colors.black, 
              size: 30.0
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          FlatButton(
            child: Icon(
              Icons.close, 
              color: Colors.black, 
              size: 30.0
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          ]
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    this.getBeacons();
  }
}

