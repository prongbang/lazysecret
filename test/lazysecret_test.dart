import 'package:flutter_test/flutter_test.dart';
import 'package:lazysecret/lazysecret.dart';
import 'package:lazysecret/lazysecret_box.dart';

void main() {
  final lazysecret = LazySecret.instance;

  test('$LazySecretBox is the default instance', () {
    expect(lazysecret, isInstanceOf<LazySecretBox>());
  });
}
