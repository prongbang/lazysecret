@JS('sodium')
library lazysecret;

import 'dart:typed_data';
import 'package:js/js.dart';

@JS('crypto_box_BEFORENMBYTES')
// ignore: non_constant_identifier_names
external num get crypto_box_BEFORENMBYTES;

@JS('crypto_box_NONCEBYTES')
// ignore: non_constant_identifier_names
external num get crypto_box_NONCEBYTES;

@JS('crypto_kx_PUBLICKEYBYTES')
// ignore: non_constant_identifier_names
external num get crypto_kx_PUBLICKEYBYTES;

@JS('crypto_kx_SECRETKEYBYTES')
// ignore: non_constant_identifier_names
external num get crypto_kx_SECRETKEYBYTES;

@JS('crypto_secretbox_KEYBYTES')
// ignore: non_constant_identifier_names
external num get crypto_secretbox_KEYBYTES;

@JS('crypto_secretbox_MACBYTES')
// ignore: non_constant_identifier_names
external num get crypto_secretbox_MACBYTES;

@JS('crypto_secretbox_NONCEBYTES')
// ignore: non_constant_identifier_names
external num get crypto_secretbox_NONCEBYTES;

@JS('crypto_kx_keypair')
// ignore: non_constant_identifier_names
external _KeyPair crypto_kx_keypair();

@JS('crypto_box_beforenm')
// ignore: non_constant_identifier_names
external Uint8List crypto_box_beforenm(Uint8List pk, Uint8List sk);

@JS('crypto_secretbox_easy')
// ignore: non_constant_identifier_names
external Uint8List crypto_secretbox_easy(Uint8List m, Uint8List n, Uint8List k);

@JS('crypto_secretbox_open_easy')
// ignore: non_constant_identifier_names
external Uint8List crypto_secretbox_open_easy(
  Uint8List c,
  Uint8List n,
  Uint8List k,
);

@JS('randombytes_buf')
// ignore: non_constant_identifier_names
external Uint8List randombytes_buf(num length);

@JS()
@anonymous
class _KeyPair {
  external factory _KeyPair({
    required Uint8List publicKey,
    required Uint8List privateKey,
    required String keyType,
  });

  external Uint8List get publicKey;

  external Uint8List get privateKey;

  external String? get keyType;
}
