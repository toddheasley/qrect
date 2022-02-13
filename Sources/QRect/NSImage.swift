#if canImport(Cocoa)
import Cocoa

extension NSImage {
    public convenience init(qrCode: QRCode, color: NSColor? = nil, scale: UInt? = nil) {
        let ciImage: CIImage = qrCode.image(color: color?.ciColor, scale: scale)
        let imageRep: NSCIImageRep = NSCIImageRep(ciImage: ciImage)
        self.init(size: imageRep.size)
        addRepresentation(imageRep)
    }
}

private extension NSColor {
    var ciColor: CIColor {
        return CIColor(color: self) ?? .clear
    }
}
#endif
