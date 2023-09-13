package com.prongbang.lazysecret.crypto.box

import com.goterl.lazysodium.LazySodium
import com.goterl.lazysodium.utils.KeyPair

class LazyBox(
    private val lazySodium: LazySodium
) {
    fun cryptoBoxBeforeNm(keyPair: KeyPair): String {
        return lazySodium.cryptoBoxBeforeNm(keyPair)
    }
}