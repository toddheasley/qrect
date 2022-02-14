#if canImport(Cocoa)
import Cocoa

extension NSImage {
    public func pngData() -> Data? {
        guard let bitmapImageRep: NSBitmapImageRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(size.width), pixelsHigh: Int(size.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0) else {
            return nil
        }
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapImageRep)
        draw(at: .zero, from: .zero, operation: .sourceOver, fraction: 1.0)
        NSGraphicsContext.restoreGraphicsState()
        return bitmapImageRep.representation(using: .png, properties: [.compressionFactor: 1.0])
    }
    
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
