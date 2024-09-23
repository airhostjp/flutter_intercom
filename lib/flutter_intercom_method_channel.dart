import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intercom/flutter_intercom.dart';
import 'package:flutter_intercom/models/intercom_login_result.dart';
import 'package:flutter_intercom/models/intercom_user_attributes.dart';

import 'flutter_intercom_platform_interface.dart';

/// An implementation of [FlutterIntercomPlatform] that uses method channels.
class MethodChannelFlutterIntercom extends FlutterIntercomPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_intercom');

  @override
  Future<void> setApiKeyForAppId({String? apiKey, String? appId}) async {
    try {
      await methodChannel.invokeMethod<void>('setApiKeyForAppId', {
        'apiKey': apiKey,
        'appId': appId,
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error setting API key for app ID: $e');
      }
    }
  }

  @override
  Future<ICMLoginResult> loginUnidentifiedUser() async {
    final dynamic result = await methodChannel.invokeMethod<dynamic>('loginUnidentifiedUser');
    return ICMLoginResult.fromJson(result.cast<String, dynamic>());
  }

  @override
  Future<ICMLoginResult> loginUser(ICMUserAttributes userAttributes) async {
    final dynamic result = await methodChannel.invokeMethod<dynamic>('loginUser', userAttributes.toJson());
    return ICMLoginResult.fromJson(result.cast<String, dynamic>());
  }

  @override
  Future<void> setUserHash(String hash) async {
    await methodChannel.invokeMethod<void>('setUserHash', {
      'hash': hash,
    });
  }

  @override
  Future<void> present(ICMSpace? space) async {
    await methodChannel.invokeMethod<void>('present', {
      'space': space?.name,
    });
  }

  @override
  Future<void> hide() async {
    await methodChannel.invokeMethod<void>('hide');
  }

  @override
  Future<void> logout() async {
    await methodChannel.invokeMethod<void>('logout');
  }
}
