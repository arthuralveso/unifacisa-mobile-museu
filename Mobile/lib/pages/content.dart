
import 'package:flutter/material.dart';
import 'package:museu/models/Beacon.dart';
import 'package:museu/pages/search-beacon.dart';


class Content extends StatelessWidget {
  final Beacon beacon;

  Content({@required this.beacon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 100,
        width: 100,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
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
                  beacon.content,
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
                  beacon.content_name,
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
                  beacon.content_description,
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
}