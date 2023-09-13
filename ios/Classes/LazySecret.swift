//
//  LazySecret.swift
//  lazysecret
//
//  Created by prongbang on 13/9/2566 BE.
//

import Foundation
import Sodium

public class LazySecret {
    private let sodium: Sodium
    
    public init(sodium: Sodium) {
        self.sodium = sodium
    }
    
    public func toHex(bytes: Bytes) -> String {
        guard let data = sodium.utils.bin2hex(bytes) else {
            return ""
        }
        
        return data
    }
    
    public func toBin(hexString: String) -> Bytes {
        guard let data = sodium.utils.hex2bin(hexString) else {
            return []
        }
        
        return data
    }
    
    public func randomBytesBuf(size: Int) -> Bytes {
        guard let data = sodium.randomBytes.buf(length: size) else {
            return []
        }
        
        return data
    }
    
    public func cryptoSecretBoxMacBytes() -> Int {
        return sodium.secretBox.MacBytes
    }
    
    public func cryptoSecretBoxNonceBytes() -> Int {
        return sodium.secretBox.NonceBytes
    }
    
    public func cryptoSecretBoxKeyBytes() -> Int {
        return sodium.secretBox.KeyBytes
    }
    
    public func cryptoKxKeyPair() -> KeyPair? {
        guard let keyPair = sodium.keyExchange.keyPair() else { return nil }
        
        return KeyPair(pk: keyPair.publicKey, sk: keyPair.secretKey)
    }
    
    public func cryptoBoxBeforeNm(keyPair: KeyPair) -> String {
        guard let bytes = sodium.box.beforenm(
            recipientPublicKey: keyPair.pk,
            senderSecretKey: keyPair.sk
        ) else {
            return ""
        }
        
        return toHex(bytes: bytes)
    }
    
    public func cryptoSecretBoxEasy(plaintext: String, nonce: String, key: String) -> String {
        let message = Bytes(plaintext.utf8)
        let nonceBytes = toBin(hexString: nonce)
        let keyBytes = toBin(hexString: key)
        
        guard let cipherBytes = sodium.secretBox.seal(
            message: message,
            secretKey: keyBytes,
            nonce: nonceBytes
        ) else {
            return ""
        }
        
        return toHex(bytes: cipherBytes)
    }
    
    public func cryptoSecretBoxOpenEasy(ciphertext: String, nonce: String, key: String) -> String {
        let keyBytes = toBin(hexString: key)
        let cipherBytes = toBin(hexString: ciphertext)
        let nonceBytes = toBin(hexString: nonce)
        
        guard let decrypted = sodium.secretBox.open(
            authenticatedCipherText: cipherBytes,
            secretKey: keyBytes,
            nonce: nonceBytes
        ) else { return "" }
        
        return String(bytes: decrypted, encoding: .utf8) ?? ""
    }
}
