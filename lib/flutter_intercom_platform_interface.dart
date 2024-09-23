import 'package:flutter_intercom/flutter_intercom.dart';
import 'package:flutter_intercom/models/intercom_login_result.dart';
import 'package:flutter_intercom/models/intercom_user_attributes.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_intercom_method_channel.dart';

abstract class FlutterIntercomPlatform extends PlatformInterface {
  /// Constructs a FlutterIntercomPlatform.
  FlutterIntercomPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterIntercomPlatform _instance = MethodChannelFlutterIntercom();

  /// The default instance of [FlutterIntercomPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterIntercom].
  static FlutterIntercomPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterIntercomPlatform] when
  /// they register themselves.
  static set instance(FlutterIntercomPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> setApiKeyForAppId({String? apiKey, String? appId}) {
    throw UnimplementedError('setApiKeyForAppId() has not been implemented.');
  }

  Future<ICMLoginResult> loginUnidentifiedUser() {
    throw UnimplementedError('loginUnidentifiedUser() has not been implemented.');
  }

  Future<ICMLoginResult> loginUser(ICMUserAttributes userAttributes) {
    throw UnimplementedError('loginUser() has not been implemented.');
  }

  Future<void> present(ICMSpace? space) {
    throw UnimplementedError('present() has not been implemented.');
  }

  Future<void> hide() {
    throw UnimplementedError('hide() has not been implemented.');
  }

  Future<void> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }
}
