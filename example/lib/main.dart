import 'package:flutter/material.dart';
import 'package:lazysecret/kx/key_pair.dart';

import 'package:lazysecret/lazysecret.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _result = '';
  final _lazysecret = LazySecret.instance;

  @override
  void initState() {
    super.initState();
    _processLazySecret();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(_result),
        ),
      ),
    );
  }

  void _processLazySecret() async {
    // Size
    final nonceSize = await _lazysecret.cryptoSecretBoxNonceBytes();
    final keySize = await _lazysecret.cryptoSecretBoxKeyBytes();
    final macSize = await _lazysecret.cryptoSecretBoxMacBytes();

    // Nonce
    final nonceByte = await _lazysecret.randomBytesBuf(nonceSize);
    final nonce = await _lazysecret.toHex(nonceByte);
    final bytesNonce = await _lazysecret.toBin(nonce);
    print('key[$keySize]');
    print('mac[$macSize]');
    print('nonce[${nonceByte.length}:$nonceSize]: $nonceByte');
    print('nonce[${nonce.length}]: $nonce');
    print('nonce[${bytesNonce.length}:${nonceByte.length}]: $bytesNonce');

    _result += 'key[$keySize]\n';
    _result += 'mac[$macSize]\n';
    _result += 'nonce[${nonceByte.length}:$nonceSize]: $nonceByte\n';
    _result += 'nonce[${nonce.length}]: $nonce\n';
    _result += 'nonce[${bytesNonce.length}:${nonceByte.length}]: $bytesNonce\n';

    // Key Pair
    final clientKeyPair = await _lazysecret.cryptoKxKeyPair();
    final serverKeyPair = await _lazysecret.cryptoKxKeyPair();

    // Key Exchange
    final clientKx = KeyPair(pk: serverKeyPair.pk, sk: clientKeyPair.sk);
    final serverKx = KeyPair(pk: clientKeyPair.pk, sk: serverKeyPair.sk);

    final clientSharedKey = await _lazysecret.cryptoBoxBeforeNm(clientKx);
    final serverSharedKey = await _lazysecret.cryptoBoxBeforeNm(serverKx);

    // Payload
    const message = 'Lazysecret';
    print('message: $message');

    // Encrypt
    final ciphertext = await _lazysecret.cryptoSecretBoxEasy(
      message,
      nonce,
      clientSharedKey,
    );
    print('ciphertext: $ciphertext');

    // Decrypt
    final plaintext = await _lazysecret.cryptoSecretBoxOpenEasy(
      ciphertext,
      nonce,
      serverSharedKey,
    );
    print('plaintext: $plaintext');

    _result += 'message: $message\n';
    _result += 'ciphertext: $ciphertext\n';
    _result += 'plaintext: $plaintext\n';

    setState(() {});
  }
}
