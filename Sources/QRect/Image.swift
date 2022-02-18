import SwiftUI

extension Image {
    public init(qrCode: QRCode, color: Color? = nil, scale: UInt? = nil) {
#if canImport(Cocoa)
        self.init(nsImage: NSImage(qrCode: qrCode, color: color?.nsColor, scale: scale))
#elseif canImport(UIKit)
        self.init(uiImage: UIImage(qrCode: qrCode, color: color?.uiColor, scale: scale))
#else
        fatalError()
#endif
    }
}

private extension Color {
#if canImport(Cocoa)
    var nsColor: NSColor {
        return NSColor(self)
    }
#elseif canImport(UIKit)
    var uiColor: UIColor {
        return UIColor(self)
    }
#endif
}
