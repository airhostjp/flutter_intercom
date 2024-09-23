import 'package:flutter_intercom/models/intercom_login_result.dart';
import 'package:flutter_intercom/models/intercom_user_attributes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_intercom/flutter_intercom.dart';
import 'package:flutter_intercom/flutter_intercom_platform_interface.dart';
import 'package:flutter_intercom/flutter_intercom_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterIntercomPlatform
    with MockPlatformInterfaceMixin
    implements FlutterIntercomPlatform {

  @override
  Future<void> setApiKeyForAppId({String? apiKey, String? appId}) => Future.value();

  @override
  Future<ICMLoginResult> loginUnidentifiedUser() => Future.value(ICMLoginResult());

  @override
  Future<ICMLoginResult> loginUser(ICMUserAttributes userAttributes) => Future.value(ICMLoginResult());

  @override
  Future<void> present(ICMSpace? space) => Future.value();

  @override
  Future<void> hide() => Future.value();

  @override
  Future<void> logout() => Future.value();
}

void main() {
  final FlutterIntercomPlatform initialPlatform = FlutterIntercomPlatform.instance;

  test('$MethodChannelFlutterIntercom is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterIntercom>());
  });

  test('setApiKeyForAppId', () async {
    FlutterIntercom flutterIntercomPlugin = FlutterIntercom();
    MockFlutterIntercomPlatform fakePlatform = MockFlutterIntercomPlatform();
    FlutterIntercomPlatform.instance = fakePlatform;

    expect(await flutterIntercomPlugin.loginUnidentifiedUser(), isNull);
  });
}
