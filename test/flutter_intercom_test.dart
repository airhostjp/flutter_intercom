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
  bool setApiKeyForAppIdCalled = false;
  bool presentCalled = false;
  bool presentArticleCalled = false;
  bool logoutCalled = false;

  @override
  Future<void> setApiKeyForAppId({String? apiKey, String? appId}) async {
    setApiKeyForAppIdCalled = true;
  }

  @override
  Future<ICMLoginResult> loginUnidentifiedUser() =>
      Future.value(ICMLoginResult());

  @override
  Future<ICMLoginResult> loginUser(ICMUserAttributes userAttributes) =>
      Future.value(ICMLoginResult());

  @override
  Future<void> setUserHash(String hash) => Future.value();

  @override
  Future<void> present(ICMSpace? space) async {
    presentCalled = true;
  }

  @override
  Future<void> presentArticle(String articleId) async {
    presentArticleCalled = true;
  }

  @override
  Future<void> hide() => Future.value();

  @override
  Future<void> logout() async {
    logoutCalled = true;
  }
}

void main() {
  final FlutterIntercomPlatform initialPlatform =
      FlutterIntercomPlatform.instance;

  test('$MethodChannelFlutterIntercom is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterIntercom>());
  });

  late FlutterIntercom flutterIntercomPlugin;
  late MockFlutterIntercomPlatform fakePlatform;

  setUp(() {
    flutterIntercomPlugin = FlutterIntercom();
    fakePlatform = MockFlutterIntercomPlatform();
    FlutterIntercomPlatform.instance = fakePlatform;
    FlutterIntercomPlatform.isPresent = false;
  });

  tearDown(() {
    FlutterIntercomPlatform.instance = initialPlatform;
    FlutterIntercomPlatform.isPresent = false;
  });

  test('setApiKeyForAppId forwards initialization to platform', () async {
    await flutterIntercomPlugin.setApiKeyForAppId(
      apiKey: 'api-key',
      appId: 'app-id',
    );

    expect(fakePlatform.setApiKeyForAppIdCalled, isTrue);
  });

  test('present always forwards to platform and marks UI as present', () async {
    await flutterIntercomPlugin.present(space: ICMSpace.home);

    expect(fakePlatform.presentCalled, isTrue);
    expect(FlutterIntercomPlatform.isPresent, isTrue);
  });

  test('presentArticle forwards to platform and marks UI as present', () async {
    await flutterIntercomPlugin.presentArticle('15941255');

    expect(fakePlatform.presentArticleCalled, isTrue);
    expect(FlutterIntercomPlatform.isPresent, isTrue);
  });

  test('logout calls platform and resets present state', () async {
    await flutterIntercomPlugin.present(space: ICMSpace.home);

    await flutterIntercomPlugin.logout();

    expect(fakePlatform.logoutCalled, isTrue);
    expect(FlutterIntercomPlatform.isPresent, isFalse);
  });
}
