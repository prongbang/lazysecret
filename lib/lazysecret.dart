import 'dart:typed_data';

import 'package:lazysecret/kx/key_pair.dart';
import 'package:lazysecret/lazysecret_box.dart';

abstract class LazySecret {
  /// Constructs a LazySecret.
  LazySecret();

  static LazySecret instance = LazySecretBox();

  Future<Uint8List> randomBytesBuf(int size) {
    throw UnimplementedError('randomBytesBuf() has not been implemented.');
  }

  Future<String> toHex(Uint8List bytes) {
    throw UnimplementedError('toHex() has not been implemented.');
  }

  Future<Uint8List> toBin(String hexString) {
    throw UnimplementedError('toBin() has not been implemented.');
  }

  Future<String> cryptoBoxBeforeNm(KeyPair keyPair) {
    throw UnimplementedError('cryptoBoxBeforeNm() has not been implemented.');
  }

  Future<String> cryptoSecretBoxEasy(
    String plaintext,
    String nonce,
    String key,
  ) {
    throw UnimplementedError('cryptoSecretBoxEasy() has not been implemented.');
  }

  Future<String> cryptoSecretBoxOpenEasy(
    String ciphertext,
    String nonce,
    String key,
  ) {
    throw UnimplementedError('cryptoSecretBoxOpenEasy() has not been implemented.');
  }

  Future<KeyPair> cryptoKxKeyPair() {
    throw UnimplementedError('cryptoKxKeyPair() has not been implemented.');
  }

  Future<int> cryptoSecretBoxKeyBytes() {
    throw UnimplementedError('cryptoSecretBoxKeyBytes() has not been implemented.');
  }

  Future<int> cryptoSecretBoxNonceBytes() {
    throw UnimplementedError('cryptoSecretBoxNonceBytes() has not been implemented.');
  }

  Future<int> cryptoSecretBoxMacBytes() {
    throw UnimplementedError('cryptoSecretBoxMacBytes() has not been implemented.');
  }
}
