import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:device_id/device_id.dart';
import 'package:museu/pages/search-beacon.dart';
import 'package:museu/pages/content.dart';
import 'package:museu/pages/register.dart';




void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
    
      debugShowCheckedModeBanner: false,
      title: 'Inova Museu',
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => new Register(),
        '/content' : (BuildContext context) => new Content(),
        '/search' : (BuildContext context) => new Search()
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _info = "";

  Future<void> initDeviceId() async {
    String deviceid = await DeviceId.getID;
    print(deviceid);
    setState(() {
      _info = deviceid;
    });
  }

  Dio _dio;

  @override
  void initState() {
    super.initState();
    initDeviceId();

    BaseOptions options = new BaseOptions(
      baseUrl: 'http://192.168.15.14:3333',
      connectTimeout: 5000,
    );

    _dio = new Dio(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.amber[300],
          ),
          child:
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 32, right: 32, bottom: 32),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Inova',
                        style: TextStyle(
                            fontSize: 80.0, 
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          )
                        ),
                    ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('Museu',
                        style: TextStyle(
                            fontSize: 80.0, 
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          )
                        ),
                     ),
                  ],
                )
              ),
            SizedBox(height: 50.0),
            Center(
              child:
              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 70,
                width: 370,
                child: RaisedButton(
              onPressed: () {
                login();
              },
              child: Text('Visite o Museu!',
              style: TextStyle(
                color: Colors.grey[350],
                fontFamily: 'Montserrat',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                ),
              ),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
              )
              
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Faça seu',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Cadastro',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline
                    ),
                  ),
                )
              ],
            ),
          ],
        )
        )
        
      );
  
  }
  

  void login() async {
    try {
      await _dio.post("/guestsessions", data: {"guest_id" : _info});
      Navigator.of(context).pushNamed('/search');

    } catch (err) {
      print(err);
      Navigator.of(context).pushNamed('/register');
    }
  }
}
