@JS('sodium')
library lazysecret;

import 'dart:typed_data';
import 'package:js/js.dart';

@JS('crypto_box_BEFORENMBYTES')
// non_constant_identifier_names
external num get crypto_box_BEFORENMBYTES;

@JS('crypto_box_NONCEBYTES')
external num get crypto_box_NONCEBYTES;

@JS('crypto_kx_PUBLICKEYBYTES')
external num get crypto_kx_PUBLICKEYBYTES;

@JS('crypto_kx_SECRETKEYBYTES')
external num get crypto_kx_SECRETKEYBYTES;

@JS('crypto_secretbox_KEYBYTES')
external num get crypto_secretbox_KEYBYTES;

@JS('crypto_secretbox_MACBYTES')
external num get crypto_secretbox_MACBYTES;

@JS('crypto_secretbox_NONCEBYTES')
external num get crypto_secretbox_NONCEBYTES;

@JS('crypto_kx_keypair')
external _KeyPair crypto_kx_keypair();

@JS('crypto_box_beforenm')
external Uint8List crypto_box_beforenm(Uint8List pk, Uint8List sk);

@JS('crypto_secretbox_easy')
external Uint8List crypto_secretbox_easy(Uint8List m, Uint8List n, Uint8List k);

@JS('crypto_secretbox_open_easy')
external Uint8List crypto_secretbox_open_easy(
  Uint8List c,
  Uint8List n,
  Uint8List k,
);

@JS('randombytes_buf')
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
