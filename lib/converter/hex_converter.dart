import 'dart:typed_data';

class HexConverter {
  static final List<String> _hexArray = "0123456789abcdef".split('');

  static String bytesToHex(Uint8List bytes) {
    List<String> hexChars = List.filled(bytes.length * 2, '');
    for (int j = 0; j < bytes.length; j++) {
      int v = bytes[j] & 0xFF;
      hexChars[j * 2] = _hexArray[v >> 4];
      hexChars[j * 2 + 1] = _hexArray[v & 0x0F];
    }
    return hexChars.join();
  }

  static Uint8List hexToBytes(String hexString) {
    int len = hexString.length;
    Uint8List data = Uint8List(len ~/ 2);
    for (int i = 0; i < len; i += 2) {
      data[i ~/ 2] = (int.parse(hexString.substring(i, i + 2), radix: 16));
    }
    return data;
  }
}
