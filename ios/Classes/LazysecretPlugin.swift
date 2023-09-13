import Flutter
import UIKit
import Sodium

public class LazySecretPlugin: NSObject, FlutterPlugin {
    
    private let lazySecretMethodChannel: LazySecretMethodChannel
    
    public init(lazySecretMethodChannel: LazySecretMethodChannel) {
        self.lazySecretMethodChannel = lazySecretMethodChannel
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "lazysecret", binaryMessenger: registrar.messenger())
        let lazysecret = LazySecret(sodium: Sodium())
        let lazySecretMethodChannel = LazySecretMethodChannel(lazysecret: lazysecret)
        let instance = LazySecretPlugin(
            lazySecretMethodChannel: lazySecretMethodChannel
        )
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        lazySecretMethodChannel.handle(call, result: result)
    }
}
