package com.prongbang.lazysecret

import com.goterl.lazysodium.interfaces.SecretBox
import com.goterl.lazysodium.utils.KeyPair
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LazySecretMethodChannel(
    private val lazySecret: LazySecret
) {

    companion object {
        private const val PARAMETER_NOT_FOUND_ERROR_CODE = "NF001"
        private const val TO_HEX_METHOD = "toHex"
        private const val TO_BIN_METHOD = "toBin"
        private const val BOX_BEFORE_NM_METHOD = "cryptoBoxBeforeNm"
        private const val SECRET_BOX_EASY_METHOD = "cryptoSecretBoxEasy"
        private const val SECRET_BOX_OPEN_EASY_METHOD = "cryptoSecretBoxOpenEasy"
        private const val CREATE_KEY_PAIR_METHOD = "cryptoKxKeyPair"
        private const val SECRET_BOX_KEY_BYTES_METHOD = "cryptoSecretBoxKeyBytes"
        private const val SECRET_BOX_NONCE_BYTES_METHOD = "cryptoSecretBoxNonceBytes"
        private const val SECRET_BOX_MAC_BYTES_METHOD = "cryptoSecretBoxMacBytes"
        private const val RANDOM_BYTES_BUF_METHOD = "randomBytesBuf"
    }

    fun methodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == SECRET_BOX_KEY_BYTES_METHOD) {
            result.success(SecretBox.KEYBYTES)
        } else if (call.method == SECRET_BOX_NONCE_BYTES_METHOD) {
            result.success(SecretBox.NONCEBYTES)
        } else if (call.method == SECRET_BOX_MAC_BYTES_METHOD) {
            result.success(SecretBox.MACBYTES)
        } else if (call.method == TO_HEX_METHOD) {
            val hasBin = call.hasArgument("bin")
            if (hasBin) {
                val bin = call.argument<ByteArray>("bin") ?: byteArrayOf()
                val hex = lazySecret.toHex(bin).lowercase()
                result.success(hex)
            } else {
                val exception = Exception("Byte arrays not found")
                result.error(PARAMETER_NOT_FOUND_ERROR_CODE, exception.message, exception)
            }
        } else if (call.method == TO_BIN_METHOD) {
            val hasHex = call.hasArgument("hex")
            if (hasHex) {
                val hex = call.argument<String>("hex") ?: ""
                result.success(lazySecret.toBin(hex))
            } else {
                val exception = Exception("Hex string not found")
                result.error(PARAMETER_NOT_FOUND_ERROR_CODE, exception.message, exception)
            }
        } else if (call.method == RANDOM_BYTES_BUF_METHOD) {
            val hasSize = call.hasArgument("size")
            if (hasSize) {
                val size = call.argument<Int>("size") ?: 0
                val bytes = lazySecret.randomBytesBuf(size)
                result.success(bytes)
            } else {
                val exception = Exception("Size not found")
                result.error(PARAMETER_NOT_FOUND_ERROR_CODE, exception.message, exception)
            }
        } else if (call.method == CREATE_KEY_PAIR_METHOD) {
            val keyPair = lazySecret.cryptoKxKeypair()
            result.success(
                mapOf(
                    "pk" to keyPair.publicKey.asHexString,
                    "sk" to keyPair.secretKey.asHexString,
                )
            )
        } else if (call.method == BOX_BEFORE_NM_METHOD) {
            val hasPk = call.hasArgument("pk")
            val hasSk = call.hasArgument("sk")
            if (hasPk && hasSk) {
                val pk = call.argument<String>("pk") ?: ""
                val sk = call.argument<String>("sk") ?: ""
                val keyPair = KeyPair(
                    lazySecret.fromHexString(pk),
                    lazySecret.fromHexString(sk),
                )
                val sharedKey = lazySecret.cryptoBoxBeforeNm(keyPair).lowercase()
                result.success(sharedKey)
            } else {
                val exception = Exception("Pk or Sk string not found")
                result.error(PARAMETER_NOT_FOUND_ERROR_CODE, exception.message, exception)
            }
        } else if (call.method == SECRET_BOX_EASY_METHOD) {
            val hasText = call.hasArgument("plaintext")
            val hasNonce = call.hasArgument("nonce")
            val hasKey = call.hasArgument("key")
            if (hasText && hasNonce && hasKey) {
                val plaintext = call.argument<String>("plaintext") ?: ""
                val nonce = call.argument<String>("nonce") ?: ""
                val key = call.argument<String>("key") ?: ""
                val data = lazySecret.cryptoSecretBoxEasy(
                    plaintext = plaintext,
                    nonce = lazySecret.toBin(nonce),
                    key = lazySecret.fromHexString(key),
                ).lowercase()
                result.success(data)
            } else {
                val exception = Exception("PlainText or nonce or key string not found")
                result.error(PARAMETER_NOT_FOUND_ERROR_CODE, exception.message, exception)
            }
        } else if (call.method == SECRET_BOX_OPEN_EASY_METHOD) {
            val hasText = call.hasArgument("ciphertext")
            val hasNonce = call.hasArgument("nonce")
            val hasKey = call.hasArgument("key")
            if (hasText && hasNonce && hasKey) {
                val text = call.argument<String>("ciphertext") ?: ""
                val nonce = call.argument<String>("nonce") ?: ""
                val key = call.argument<String>("key") ?: ""
                val data = lazySecret.cryptoSecretBoxOpenEasy(
                    ciphertext = text,
                    nonce = lazySecret.toBin(nonce),
                    key = lazySecret.fromHexString(key),
                )
                result.success(data)
            } else {
                val exception = Exception("CipherText or nonce or key string not found")
                result.error(PARAMETER_NOT_FOUND_ERROR_CODE, exception.message, exception)
            }
        } else {
            result.notImplemented()
        }
    }
}