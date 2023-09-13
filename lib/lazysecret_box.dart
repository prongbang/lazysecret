import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lazysecret/lazysecret.dart';

/// An implementation of [LazySecret] that uses method channels.
class LazySecretBox extends LazySecret {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lazysecret');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
