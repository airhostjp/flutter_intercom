import Flutter
import UIKit
import Intercom

public class FlutterIntercomPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_intercom", binaryMessenger: registrar.messenger())
        let instance = FlutterIntercomPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setApiKeyForAppId":
            if let args = call.arguments as? [String: Any],
               let apiKey = args["apiKey"] as? String,
               let appId = args["appId"] as? String {
                Intercom.setApiKey(apiKey, forAppId: appId)
                result("Success")
            } else {
                result(FlutterError(code: "ERROR", message: "Invalid arguments", details: nil))
            }
            return
        case "loginUnidentifiedUser":
            Intercom.loginUnidentifiedUser { res in
                switch res {
                case .success:
                    result([
                        "success": true,
                        "message": "Successfully logged in as an unidentified user.",
                    ])
                    break
                case .failure(let error):
                    result([
                        "success": false,
                        "message": error.localizedDescription,
                    ])
                    break
                }
            }
            return
        case "loginUser":
            let attributes = ICMUserAttributes()
            if let args = call.arguments as? [String: Any] {
                if let userId = args["userId"] as? String, !userId.isEmpty {
                    attributes.userId = userId
                }
                if let email = args["email"] as? String, !email.isEmpty {
                    attributes.email = email
                }
                if let phone = args["phone"] as? String, !phone.isEmpty {
                    attributes.phone = phone
                }
                if let name = args["name"] as? String, !name.isEmpty {
                    attributes.name = name
                }
                if let languageOverride = args["languageOverride"] as? String, !languageOverride.isEmpty {
                    attributes.languageOverride = languageOverride
                }
                if let customAttributes = args["customAttributes"] as? [String: Any], !customAttributes.isEmpty {
                    attributes.customAttributes = customAttributes
                }
            }
            Intercom.loginUser(with: attributes) { res in
                switch res {
                case .success:
                    result([
                        "success": true,
                        "message": "Successfully logged in.",
                    ])
                    break
                case .failure(let error):
                    result([
                        "success": false,
                        "message": error.localizedDescription,
                    ])
                    break
                }
            }
            return
        case "setUserHash":
            if let args = call.arguments as? [String: Any],
               let hash = args["hash"] as? String {
                Intercom.setUserHash(hash)
            }
            return
        case "present":
            if let args = call.arguments as? [String: Any],
               let space = args["space"] as? String {
                switch space {
                case "home":
                    Intercom.present(.home)
                case "helpCenter":
                    Intercom.present(.helpCenter)
                case "messages":
                    Intercom.present(.messages)
                case "tickets":
                    Intercom.present(.tickets)
                default:
                    Intercom.present(.home)
                }
            } else {
                Intercom.present()
            }
            return
        case "hide":
            Intercom.hide()
            return
        case "logout":
            Intercom.logout()
            return
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
