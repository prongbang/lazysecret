import 'package:lazysecret/lazysecret_box.dart';

class LazySecret {
  /// Constructs a LazySecret.
  LazySecret();

  static LazySecret instance = LazySecretBox();

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
