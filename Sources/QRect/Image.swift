import SwiftUI

extension Image {
    public init(qrCode: QRCode, color: Color? = nil, scale: UInt? = nil) {
#if canImport(AppKit)
        let color: NSColor? = color != nil ? NSColor(color!) : nil
        self.init(nsImage: NSImage(qrCode: qrCode, color: color, scale: scale))
#elseif canImport(UIKit)
        let color: UIColor? = color != nil ? UIColor(color!) : nil
        self.init(uiImage: UIImage(qrCode: qrCode, color: color, scale: scale))
#else
        fatalError()
#endif
    }
}
