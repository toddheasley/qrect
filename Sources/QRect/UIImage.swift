#if canImport(UIKit)
import UIKit

extension UIImage {
    public convenience init(qrCode: QRCode, color: UIColor? = nil, scale: UInt? = nil) {
        self.init(ciImage: qrCode.image(color: color?.ciColor, scale: scale))
    }
}

private extension UIColor {
    var ciColor: CIColor {
        return CIColor(color: self)
    }
}
#endif
