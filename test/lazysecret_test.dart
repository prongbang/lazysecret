import 'package:flutter/src/services/platform_channel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazysecret/lazysecret.dart';
import 'package:lazysecret/lazysecret_box.dart';

class MockLazySecretBox implements LazySecretBox {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  MethodChannel get methodChannel => const MethodChannel('lazysecret');
}

void main() {
  final initialBox = LazySecret.instance;

  test('$LazySecretBox is the default instance', () {
    expect(initialBox, isInstanceOf<LazySecretBox>());
  });

  test('getPlatformVersion', () async {
    LazySecret lazySecretPlugin = LazySecret();
    MockLazySecretBox fakeBox = MockLazySecretBox();
    LazySecret.instance = fakeBox;

    expect(await lazySecretPlugin.getPlatformVersion(), '42');
  });
}
