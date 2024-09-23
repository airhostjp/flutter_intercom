import 'package:flutter_intercom/models/intercom_login_result.dart';
import 'package:flutter_intercom/models/intercom_user_attributes.dart';

import 'flutter_intercom_platform_interface.dart';

enum ICMSpace {
  home,
  helpCenter,
  messages,
  tickets,
}

class FlutterIntercom {
  Future<void> setApiKeyForAppId({String? apiKey, String? appId}) {
    return FlutterIntercomPlatform.instance.setApiKeyForAppId(apiKey: apiKey, appId: appId);
  }

  Future<ICMLoginResult> loginUnidentifiedUser() {
    return FlutterIntercomPlatform.instance.loginUnidentifiedUser();
  }

  Future<ICMLoginResult> loginUser(ICMUserAttributes userAttributes) {
    return FlutterIntercomPlatform.instance.loginUser(userAttributes);
  }

  Future<void> present({ICMSpace? space}) {
    return FlutterIntercomPlatform.instance.present(space);
  }

  Future<void> hide() {
    return FlutterIntercomPlatform.instance.hide();
  }

  Future<void> logout() {
    return FlutterIntercomPlatform.instance.logout();
  }
}
