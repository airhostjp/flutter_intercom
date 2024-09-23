import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_intercom/flutter_intercom.dart';
import 'package:flutter_intercom/models/intercom_user_attributes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterIntercomPlugin = FlutterIntercom();

  @override
  void initState() {
    super.initState();
    String? apiKey;
    if (Platform.isAndroid) {
      apiKey = 'android_sdk-*****';
    } else {
      apiKey = 'ios_sdk-*****';
    }
    _flutterIntercomPlugin.setApiKeyForAppId(apiKey: apiKey, appId: '*****');
    // _flutterIntercomPlugin.loginUnidentifiedUser();
    _flutterIntercomPlugin.loginUser(ICMUserAttributes(
        email: '*****@gmail.com',
      ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: ${Platform.isAndroid ? 'Android' : 'iOS'}'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _flutterIntercomPlugin.present(space: ICMSpace.home);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        )
      ),
    );
  }
}
