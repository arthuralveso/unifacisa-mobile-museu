import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:device_id/device_id.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() {
    return _SignupPageState();
  }
}

class _SignupPageState extends State<SignupPage> {
  String _info = "";

  Future<void> initDeviceId() async {
    String deviceid = await DeviceId.getID;
    setState(() {
      _info = deviceid;
    });
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();

  Dio _dio;

  @override
  void initState() {
    super.initState();
    initDeviceId();

    BaseOptions options = new BaseOptions(
      baseUrl: 'http://192.168.15.15:3000',
      connectTimeout: 5000,
    );

    _dio = new Dio(options);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
           decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/fotoMuseu.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Cadastro',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(325.0, 120.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty) return "O campo é obrigatório";
                        return null;
                      },
                      controller: _name,
                      decoration: InputDecoration(
                          labelText: 'NOME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange
                          )
                        )
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      validator: (value) {
                        if(value.isEmpty) return "O campo é obrigatório";
                        return null;
                      },
                      controller: _email,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w800,
                            ),
                          focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                      obscureText: false,
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      width: 500,
                      color: Colors.transparent,
                      child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              submitGuest();
                            }
                          },
                            child: Text('Cadastre-se',
                            style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            ),
                          ),
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      width: 500,
                      color: Colors.transparent,
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                            child: Text('Voltar',
                            style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            ),
                          ),
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                )
              ),
          )  
        ]
      ),
        )
        
    );
  }
  void submitGuest() async {
    await _dio.post("/guests", data: {
      "phone_id": _info,
      "name": _name.text,
      "email": _email.text,
      });

      setState(() {
        _name.text = "";
        _email.text = "";
      });
      await _dio.post("/guestsessions", data: {"guest_id" : _info});
      Navigator.of(context).pushNamed('/login');
  }
}