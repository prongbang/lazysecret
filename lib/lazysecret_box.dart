import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lazysecret/kx/key_pair.dart';
import 'package:lazysecret/lazysecret.dart';

/// An implementation of [LazySecret] that uses method channels.
class LazySecretBox extends LazySecret {
  final String toHexMethod = 'toHex';
  final String toBinMethod = 'toBin';
  final String boxBeforeNmMethod = 'cryptoBoxBeforeNm';
  final String secretBoxEasyMethod = 'cryptoSecretBoxEasy';
  final String secretBoxOpenEasyMethod = 'cryptoSecretBoxOpenEasy';
  final String createKeyPairMethod = 'cryptoKxKeyPair';
  final String secretBoxKeyBytesMethod = 'cryptoSecretBoxKeyBytes';
  final String secretBoxNonceBytesMethod = 'cryptoSecretBoxNonceBytes';
  final String secretBoxMacBytesMethod = 'cryptoSecretBoxMacBytes';
  final String randomBytesBufMethod = 'randomBytesBuf';

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lazysecret');

  @override
  Future<Uint8List> randomBytesBuf(int size) async {
    final data = await methodChannel.invokeMethod<Uint8List>(
      randomBytesBufMethod,
      <String, dynamic>{
        'size': size,
      },
    );
    return data ?? Uint8List(0);
  }

  @override
  Future<String> toHex(Uint8List bytes) async {
    final data = await methodChannel.invokeMethod<String>(
      toHexMethod,
      <String, dynamic>{
        'bin': bytes,
      },
    );
    return data ?? '';
  }

  @override
  Future<Uint8List> toBin(String hexString) async {
    final data = await methodChannel.invokeMethod<Uint8List>(
      toBinMethod,
      <String, dynamic>{
        'hex': hexString,
      },
    );
    return data ?? Uint8List(0);
  }

  @override
  Future<String> cryptoBoxBeforeNm(KeyPair keyPair) async {
    final data = await methodChannel.invokeMethod<String>(
      boxBeforeNmMethod,
      <String, dynamic>{
        'pk': keyPair.pk,
        'sk': keyPair.sk,
      },
    );
    return data ?? '';
  }

  @override
  Future<String> cryptoSecretBoxEasy(
    String plaintext,
    String nonce,
    String key,
  ) async {
    final data = await methodChannel.invokeMethod<String>(
      secretBoxEasyMethod,
      <String, dynamic>{
        'plaintext': plaintext,
        'nonce': nonce,
        'key': key,
      },
    );
    return data ?? '';
  }

  @override
  Future<String> cryptoSecretBoxOpenEasy(
    String ciphertext,
    String nonce,
    String key,
  ) async {
    final data = await methodChannel.invokeMethod<String>(
      secretBoxOpenEasyMethod,
      <String, dynamic>{
        'ciphertext': ciphertext,
        'nonce': nonce,
        'key': key,
      },
    );
    return data ?? '';
  }

  @override
  Future<KeyPair> cryptoKxKeyPair() async {
    final data = await methodChannel
            .invokeMethod<Map<Object?, Object?>>(createKeyPairMethod) ??
        <String, dynamic>{};
    return KeyPair.fromJson(data);
  }

  @override
  Future<int> cryptoSecretBoxKeyBytes() async {
    final data = await methodChannel.invokeMethod<int>(secretBoxKeyBytesMethod);
    return data ?? 0;
  }

  @override
  Future<int> cryptoSecretBoxNonceBytes() async {
    final data =
        await methodChannel.invokeMethod<int>(secretBoxNonceBytesMethod);
    return data ?? 0;
  }

  @override
  Future<int> cryptoSecretBoxMacBytes() async {
    final data = await methodChannel.invokeMethod<int>(secretBoxMacBytesMethod);
    return data ?? 0;
  }
}
