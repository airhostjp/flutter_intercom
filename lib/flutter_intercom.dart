import 'package:flutter_intercom/models/intercom_login_result.dart';
import 'package:flutter_intercom/models/intercom_user_attributes.dart';

import 'flutter_intercom_platform_interface.dart';

enum ICMSpace { home, helpCenter, messages, tickets }

class FlutterIntercom {
  Future<void> setApiKeyForAppId({String? apiKey, String? appId}) async {
    await FlutterIntercomPlatform.instance.setApiKeyForAppId(
      apiKey: apiKey,
      appId: appId,
    );
  }

  Future<ICMLoginResult> loginUnidentifiedUser() {
    return FlutterIntercomPlatform.instance.loginUnidentifiedUser();
  }

  Future<ICMLoginResult> loginUser(ICMUserAttributes userAttributes) {
    return FlutterIntercomPlatform.instance.loginUser(userAttributes);
  }

  Future<void> setLanguageOverride(String languageCode) {
    return FlutterIntercomPlatform.instance.setLanguageOverride(languageCode);
  }

  Future<void> setUserHash(String hash) {
    return FlutterIntercomPlatform.instance.setUserHash(hash);
  }

  Future<void> present({ICMSpace? space}) async {
    await FlutterIntercomPlatform.instance.present(space);
    FlutterIntercomPlatform.isPresent = true;
  }

  Future<void> presentArticle(String articleId) async {
    await FlutterIntercomPlatform.instance.presentArticle(articleId);
    FlutterIntercomPlatform.isPresent = true;
  }

  Future<void> hide() async {
    await FlutterIntercomPlatform.instance.hide();
    FlutterIntercomPlatform.isPresent = false;
  }

  Future<void> logout() async {
    await FlutterIntercomPlatform.instance.logout();
    FlutterIntercomPlatform.isPresent = false;
  }
}
