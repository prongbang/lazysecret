package com.prongbang.lazysecret.helper

import com.goterl.lazysodium.LazySodium

class LazyHelper(
    private val lazySodium: LazySodium
) {

    fun randomBytesBuf(size: Int): ByteArray {
        return lazySodium.randomBytesBuf(size)
    }

    fun toHex(bytes: ByteArray): String {
        return lazySodium.toHexStr(bytes)
    }

    fun toBin(hexString: String): ByteArray {
        return lazySodium.toBinary(hexString)
    }

}