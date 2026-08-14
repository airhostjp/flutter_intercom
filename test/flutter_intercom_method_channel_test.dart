import 'package:flutter/services.dart';
import 'package:flutter_intercom/flutter_intercom_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('flutter_intercom');
  late MethodCall? lastMethodCall;

  setUp(() {
    lastMethodCall = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        lastMethodCall = methodCall;
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('setLanguageOverride sends language code through the method channel',
      () async {
    final plugin = MethodChannelFlutterIntercom();

    await plugin.setLanguageOverride('zh-CN');

    expect(lastMethodCall?.method, 'setLanguageOverride');
    expect(lastMethodCall?.arguments, containsPair('languageCode', 'zh-CN'));
  });
}
