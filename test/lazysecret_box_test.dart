import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazysecret/lazysecret.dart';
import 'package:lazysecret/lazysecret_box.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  LazySecret lazySecret = LazySecretBox();

  const MethodChannel channel = MethodChannel('lazysecret');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await lazySecret.getPlatformVersion(), '42');
  });
}
