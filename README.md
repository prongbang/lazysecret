# lazysecret

Lazysecret is a comprehensive Flutter implementation of the [libsodium](https://libsodium.gitbook.io/doc/secret-key_cryptography/secretbox) using secret_box library.

## Usage

- pubspec.yml

```yaml
dependencies:
  lazysecret: ^1.0.1
```

- Dart

```dart
final lazysecret = LazySecret.instance;
```

## Function

```dart
  Future<Uint8List> randomBytesBuf(int size)

  Future<String> toHex(Uint8List bytes)

  Future<Uint8List> toBin(String hexString)

  Future<String> cryptoBoxBeforeNm(KeyPair keyPair)

  Future<String> cryptoSecretBoxEasy(String plaintext, String nonce, String key)

  Future<String> cryptoSecretBoxOpenEasy(String ciphertext, String nonce, String key)

  Future<KeyPair> cryptoKxKeyPair()

  Future<int> cryptoSecretBoxKeyBytes()

  Future<int> cryptoSecretBoxNonceBytes()

  Future<int> cryptoSecretBoxMacBytes()
```


### Android

- proguard-rules.pro

```
-keep class com.sun.jna.** { *; }
-keep class * implements com.sun.jna.** { *; }
-dontwarn java.awt.*
-keepclassmembers class * extends com.sun.jna.* { public *; }
-keepclassmembers class * extends com.sun.jna.** {
    <fields>;
    <methods>;
}
```

## Documentation

https://libsodium.gitbook.io/doc/secret-key_cryptography/secretbox

Sodium is a modern, easy-to-use software library for encryption, decryption, signatures, password hashing, and more.

