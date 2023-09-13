package com.prongbang.lazysecret

import com.goterl.lazysodium.LazySodiumAndroid
import com.goterl.lazysodium.SodiumAndroid
import com.goterl.lazysodium.utils.Key
import com.goterl.lazysodium.utils.KeyPair
import com.prongbang.lazysecret.crypto.box.LazyBox
import com.prongbang.lazysecret.crypto.secretbox.LazySecretBox
import com.prongbang.lazysecret.helper.LazyHelper
import com.prongbang.lazysecret.kx.LazyKx

class LazySecret(
    private val lazyKx: LazyKx,
    private val lazyBox: LazyBox,
    private val lazySecretBox: LazySecretBox,
    private val lazyHelper: LazyHelper,
) {
    fun randomBytesBuf(size: Int): ByteArray = lazyHelper.randomBytesBuf(size)

    fun fromHexString(hextString: String): Key = lazyKx.fromHexString(hextString)

    fun cryptoKxKeypair(): KeyPair = lazyKx.cryptoKxKeypair()

    fun toHex(bytes: ByteArray): String = lazyHelper.toHex(bytes)

    fun toBin(hexString: String): ByteArray = lazyHelper.toBin(hexString)

    fun cryptoSecretBoxEasy(plaintext: String, nonce: ByteArray, key: Key): String =
        lazySecretBox.cryptoSecretBoxEasy(plaintext, nonce, key)

    fun cryptoSecretBoxOpenEasy(ciphertext: String, nonce: ByteArray, key: Key): String {
        return lazySecretBox.cryptoSecretBoxOpenEasy(ciphertext, nonce, key)
    }

    fun cryptoBoxBeforeNm(keyPair: KeyPair): String = lazyBox.cryptoBoxBeforeNm(keyPair)

    companion object {
        fun newInstance(): LazySecret {
            val lazySodiumAndroid = LazySodiumAndroid(SodiumAndroid())
            return LazySecret(
                lazyBox = LazyBox(lazySodiumAndroid),
                lazySecretBox = LazySecretBox(lazySodiumAndroid),
                lazyKx = LazyKx(lazySodiumAndroid),
                lazyHelper = LazyHelper(lazySodiumAndroid),
            )
        }
    }
}