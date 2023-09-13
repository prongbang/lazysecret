package com.prongbang.lazysecret.crypto.secretbox

import com.goterl.lazysodium.LazySodium
import com.goterl.lazysodium.utils.Key

class LazySecretBox(
    private val lazySodium: LazySodium
) {

    fun cryptoSecretBoxEasy(plaintext: String, nonce: ByteArray, key: Key): String {
        return lazySodium.cryptoSecretBoxEasy(plaintext, nonce, key)
    }

    fun cryptoSecretBoxOpenEasy(ciphertext: String, nonce: ByteArray, key: Key): String {
        return lazySodium.cryptoSecretBoxOpenEasy(ciphertext, nonce, key)
    }

}