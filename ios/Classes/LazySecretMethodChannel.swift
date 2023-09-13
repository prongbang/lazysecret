//
//  LazySecretMethodChannel.swift
//  lazysecret
//
//  Created by prongbang on 13/9/2566 BE.
//

import Flutter
import Sodium

public class LazySecretMethodChannel {
    
    private let lazysecret: LazySecret
    
    public init(lazysecret: LazySecret) {
        self.lazysecret = lazysecret
    }
    
    enum ErrorCode {
        static let parameterNotFoundErrorCode = "NF001"
    }
    
    enum Method {
        static let toHexMethod = "toHex"
        static let toBinMethod = "toBin"
        static let boxBeforeNmMethod = "cryptoBoxBeforeNm"
        static let secretBoxEasyMethod = "cryptoSecretBoxEasy"
        static let secretBoxOpenEasyMethod = "cryptoSecretBoxOpenEasy"
        static let createKeyPairMethod = "cryptoKxKeyPair"
        static let secretBoxKeyBytesMethod = "cryptoSecretBoxKeyBytes"
        static let secretBoxNonceBytesMethod = "cryptoSecretBoxNonceBytes"
        static let secretBoxMacBytesMethod = "cryptoSecretBoxMacBytes"
        static let randomBytesBufMethod = "randomBytesBuf"
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case Method.toHexMethod:
            let message = "Byte arrays not found"
            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(messageError(message: message))
                return
            }
            guard let binAny = args["bin"] else {
                result(messageError(message: message))
                return
            }
            guard let bytes = parseBytes(from: binAny) else {
                result(messageError(message: message))
                return
            }
            let data = lazysecret.toHex(bytes: bytes)
            result(data)
            break
        case Method.toBinMethod:
            let message = "Hex string not found"
            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(messageError(message: message))
                return
            }
            guard let hexAny = args["hex"] else {
                result(messageError(message: message))
                return
            }
            guard let hex = parseString(from: hexAny) else {
                result(messageError(message: message))
                return
            }
            let data = lazysecret.toBin(hexString: hex)
            result(data)
            break
        case Method.boxBeforeNmMethod:
            let message = "Pk or Sk string not found"
            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(messageError(message: message))
                return
            }
            guard let pkAny = args["pk"] else {
                result(messageError(message: message))
                return
            }
            guard let skAny = args["sk"] else {
                result(messageError(message: message))
                return
            }
            guard let pk = parseString(from: pkAny) else {
                result(messageError(message: message))
                return
            }
            guard let sk = parseString(from: skAny) else {
                result(messageError(message: message))
                return
            }
            let keyPair = KeyPair(
                pk: lazysecret.toBin(hexString: pk),
                sk: lazysecret.toBin(hexString: sk)
            )
            let data = lazysecret.cryptoBoxBeforeNm(keyPair: keyPair)
            result(data)
            break
        case Method.secretBoxEasyMethod:
            let message = "PlainText or nonce or key string not found"
            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(messageError(message: message))
                return
            }
            guard let plaintextAny = args["plaintext"] else {
                result(messageError(message: message))
                return
            }
            guard let nonceAny = args["nonce"] else {
                result(messageError(message: message))
                return
            }
            guard let keyAny = args["key"] else {
                result(messageError(message: message))
                return
            }
            guard let plaintext = parseString(from: plaintextAny) else {
                result(messageError(message: message))
                return
            }
            guard let nonce = parseString(from: nonceAny) else {
                result(messageError(message: message))
                return
            }
            guard let key = parseString(from: keyAny) else {
                result(messageError(message: message))
                return
            }
            let data = lazysecret.cryptoSecretBoxEasy(
                plaintext: plaintext,
                nonce: nonce,
                key: key
            )
            result(data)
            break
        case Method.secretBoxOpenEasyMethod:
            let message = "CipherText or nonce or key string not found"
            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(messageError(message: message))
                return
            }
            guard let ciphertextAny = args["ciphertext"] else {
                result(messageError(message: message))
                return
            }
            guard let nonceAny = args["nonce"] else {
                result(messageError(message: message))
                return
            }
            guard let keyAny = args["key"] else {
                result(messageError(message: message))
                return
            }
            guard let ciphertext = parseString(from: ciphertextAny) else {
                result(messageError(message: message))
                return
            }
            guard let nonce = parseString(from: nonceAny) else {
                result(messageError(message: message))
                return
            }
            guard let key = parseString(from: keyAny) else {
                result(messageError(message: message))
                return
            }
            let data = lazysecret.cryptoSecretBoxOpenEasy(
                ciphertext: ciphertext,
                nonce: nonce,
                key: key
            )
            result(data)
            break
        case Method.createKeyPairMethod:
            guard let keyPair = lazysecret.cryptoKxKeyPair() else {
                let data: [String: String] = [:]
                result(data)
                return
            }
            let data: [String: String] = [
                "pk": lazysecret.toHex(bytes: keyPair.pk),
                "sk": lazysecret.toHex(bytes: keyPair.sk),
            ]
            result(data)
            break
        case Method.secretBoxKeyBytesMethod:
            let size = lazysecret.cryptoSecretBoxKeyBytes()
            result(size)
            break
        case Method.secretBoxNonceBytesMethod:
            let size = lazysecret.cryptoSecretBoxNonceBytes()
            result(size)
            break
        case Method.secretBoxMacBytesMethod:
            let size = lazysecret.cryptoSecretBoxMacBytes()
            result(size)
            break
        case Method.randomBytesBufMethod:
            let message = "Size not found"
            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(messageError(message: message))
                return
            }
            guard let sizeAny = args["size"] else {
                result(messageError(message: message))
                return
            }
            guard let size = parseInt(from: sizeAny) else {
                result(messageError(message: message))
                return
            }
            let data = lazysecret.randomBytesBuf(size: size)
            result(data)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func messageError(message: String) -> FlutterError {
        return FlutterError(
            code: ErrorCode.parameterNotFoundErrorCode,
            message: message,
            details: nil
        )
    }
    
    func parseInt(from value: Any) -> Int? {
        if let intValue = value as? Int {
            return intValue
        } else if let stringValue = value as? String, let intValue = Int(stringValue) {
            return intValue
        } else {
            return nil
        }
    }
    
    func parseBytes(from value: Any) -> Bytes? {
        if let byteArray = value as? Bytes {
            return byteArray
        } else if let intValue = value as? Int {
            return [UInt8(intValue)]
        } else if let stringValue = value as? String, let intValue = Int(stringValue) {
            return [UInt8(intValue)]
        } else {
            return nil
        }
    }
    
    func parseString(from value: Any) -> String? {
        if let stringValue = value as? String {
            return stringValue
        } else if let intValue = value as? Int {
            return String(intValue)
        } else if let doubleValue = value as? Double {
            return String(doubleValue)
        } else {
            return nil
        }
    }
    
}
