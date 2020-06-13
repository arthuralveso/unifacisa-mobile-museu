import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:museu/models/Beacon.dart';

class BeaconController {


  Future<Beacon> getBeaconById(String id) async {
    final response = await http.get(
      'http://192.168.15.14/beacons' +'/?idBeacon=' + id,
    );
    Iterable list = json.decode(response.body);
    return list.map((model) => Beacon.fromJson(model)).toList()[0];
  }
}
