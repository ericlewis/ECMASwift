import Foundation
import JavaScriptCore

// https://developer.mozilla.org/en-US/docs/Web/API/TextEncoder

@objc protocol TextEncoderExports: JSExport {
    var encoding: String { get set }
    func encode(_ input: String) -> [UInt8]
}

class TextEncoder: NSObject, TextEncoderExports {
    var encoding: String = "utf-8"
    
    func encode(_ input: String) -> [UInt8] {
        return Array(input.utf8)
    }
}

public struct TextEncoderAPI {
    public func registerAPIInto(context: JSContext) {
        let textEncoderClass: @convention(block) () -> TextEncoder = {
            TextEncoder()
        }
        context.setObject(
            unsafeBitCast(textEncoderClass, to: AnyObject.self),
            forKeyedSubscript: "TextEncoder" as NSString
        )
    }
}
