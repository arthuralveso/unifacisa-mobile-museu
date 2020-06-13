import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:beacons_plugin/beacons_plugin.dart';

import 'package:museu/controllers/BeaconController.dart';
import 'package:museu/models/Beacon.dart';
import 'package:museu/pages/content.dart';

class Search extends StatelessWidget {

  final BeaconController beaconController = new BeaconController();
  final StreamController<String> beaconEventsController = StreamController<String>();


Future<void> initPlatformState(BuildContext context) async {
    BeaconsPlugin.listenToBeacons(beaconEventsController);
    Stream beacons = beaconEventsController.stream;

    beacons.listen(
        (data) async {
          if (data.isNotEmpty) {
            var beaconData = jsonDecode(data);

            await getBeaconById(context, beaconData['uuid']);
          }
        },
        onDone: () {},
        onError: (error) {
          print("Error: $error");
        });

    // await BeaconsPlugin.runInBackground(true);

    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring;
        }
      });
    } else if (Platform.isIOS) {
      await BeaconsPlugin.startMonitoring;
    }
  }

  Future getBeaconById(BuildContext cntext, String id) async {
    // await BeaconsPlugin.stopMonitoring;

    Beacon founded = await beaconController.getBeaconById(id);

    beaconEventsController.close();

    Navigator.push(
        cntext,
        MaterialPageRoute(
            builder: (context) => Content(beacon: founded)));
  }

  @override
  Widget build(BuildContext context) {
    initPlatformState(context);
    return Scaffold(
      backgroundColor: Colors.amber[300],
      
    );
  }
}