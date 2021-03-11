import 'package:datalogic/decode/barcode_manager.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:datalogic/datalogic.dart';
import 'package:datalogic/device/info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _sdkVersion = 'Unknown';
  BarcodeScannerType _t;

  @override
  void initState() {
    super.initState();
    initDatalogic();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     platformVersion = await Datalogic.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  Future<void> initDatalogic() async {
    String sdkVersion;

    try {
      sdkVersion = await SYSTEM.sdkVersion;
    } on PlatformException {
      sdkVersion = "Failed to Get SDK Version";
    }

    try {
      _t = await SYSTEM.barcodeScannerType;
      print(_t);
    } on Exception catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState((){
      _sdkVersion = sdkVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: FutureBuilder(
                future: BarcodeManager.isInitialized,
                builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == true) {
                        return StreamBuilder(
                          stream: BarcodeManager.onReadStream(),
                          builder: (context, snapshot) {
                            return Container(child: Center(child: Text(
                                "Barcode Data: ${snapshot.data}")));
                          },
                        );
                      }
                    }
                    return Container(child: Center(child: Text('Starting Stream... SDK Version: $_sdkVersion')));
                    }
        ),
    ),
    );

  }
}
