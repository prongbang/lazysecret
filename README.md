# lazysecret

Lazysecret is a comprehensive Flutter implementation of the [libsodium](https://libsodium.gitbook.io/doc/secret-key_cryptography/secretbox) using secret_box library.

## Usage

- pubspec.yml

```yaml
dependencies:
  lazysecret: ^1.0.5
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

### Web

1. Download the `sodium.js` file

https://raw.githubusercontent.com/jedisct1/libsodium.js/master/dist/browsers-sumo/sodium.js

2. Add `sodium.js` to `web` directory

```
.
└── web
    ├── ...
    └── sodium.js  <- here
```

3. Add script in `web/index.html`

```html
<script src="sodium.js"></script>
```

4. Add `LazySecret.init()` in `main.dart`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LazySecret.init();

  runApp(const MyApp());
}
```

## Documentation

https://libsodium.gitbook.io/doc/secret-key_cryptography/secretbox

Sodium is a modern, easy-to-use software library for encryption, decryption, signatures, password hashing, and more.

