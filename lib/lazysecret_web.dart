import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:lazysecret/converter/hex_converter.dart';
import 'package:lazysecret/kx/key_pair.dart';
import 'package:lazysecret/lazysecret.dart';

import 'interop/sodium_interop.dart' as interop;

class LazySecretWeb extends LazySecret {
  LazySecretWeb();

  static void registerWith(Registrar registrar) {
    LazySecret.instance = LazySecretWeb();
  }

  @override
  Future<Uint8List> randomBytesBuf(int size) async {
    return interop.randombytes_buf(size);
  }

  @override
  Future<String> toHex(Uint8List bytes) async {
    return HexConverter.bytesToHex(bytes);
  }

  @override
  Future<Uint8List> toBin(String hexString) async {
    return HexConverter.hexToBytes(hexString);
  }

  @override
  Future<String> cryptoBoxBeforeNm(KeyPair keyPair) async {
    final pk = HexConverter.hexToBytes(keyPair.pk);
    final sk = HexConverter.hexToBytes(keyPair.sk);
    final result = interop.crypto_box_beforenm(pk, sk);
    return HexConverter.bytesToHex(result);
  }

  @override
  Future<String> cryptoSecretBoxEasy(
    String plaintext,
    String nonce,
    String key,
  ) async {
    final m = Uint8List.fromList(plaintext.codeUnits);
    final n = HexConverter.hexToBytes(nonce);
    final k = HexConverter.hexToBytes(key);
    final result = interop.crypto_secretbox_easy(m, n, k);
    return HexConverter.bytesToHex(result);
  }

  @override
  Future<String> cryptoSecretBoxOpenEasy(
    String ciphertext,
    String nonce,
    String key,
  ) async {
    final c = HexConverter.hexToBytes(ciphertext);
    final n = HexConverter.hexToBytes(nonce);
    final k = HexConverter.hexToBytes(key);
    final result = interop.crypto_secretbox_open_easy(c, n, k);
    return String.fromCharCodes(result);
  }

  @override
  Future<KeyPair> cryptoKxKeyPair() async {
    final kx = interop.crypto_kx_keypair();
    return KeyPair(
      pk: HexConverter.bytesToHex(kx.publicKey),
      sk: HexConverter.bytesToHex(kx.privateKey),
    );
  }

  @override
  Future<int> cryptoSecretBoxKeyBytes() async {
    return interop.crypto_secretbox_KEYBYTES.toInt();
  }

  @override
  Future<int> cryptoSecretBoxNonceBytes() async {
    return interop.crypto_secretbox_NONCEBYTES.toInt();
  }

  @override
  Future<int> cryptoSecretBoxMacBytes() async {
    return interop.crypto_secretbox_MACBYTES.toInt();
  }
}
