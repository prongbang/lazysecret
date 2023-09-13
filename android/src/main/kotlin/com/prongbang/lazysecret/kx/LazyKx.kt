package com.prongbang.lazysecret.kx

import com.goterl.lazysodium.LazySodium
import com.goterl.lazysodium.utils.Key
import com.goterl.lazysodium.utils.KeyPair

class LazyKx(
    private val lazySodium: LazySodium
) {

    fun fromHexString(hextString: String): Key {
        return Key.fromHexString(hextString)
    }

    fun cryptoKxKeypair(): KeyPair {
        return lazySodium.cryptoKxKeypair()
    }
}