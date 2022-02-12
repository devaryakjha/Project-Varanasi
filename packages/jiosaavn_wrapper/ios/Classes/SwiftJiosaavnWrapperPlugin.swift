import Flutter
import UIKit

public class SwiftJiosaavnWrapperPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "jiosaavn_wrapper", binaryMessenger: registrar.messenger())
    let instance = SwiftJiosaavnWrapperPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
