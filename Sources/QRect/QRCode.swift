import CoreImage

public struct QRCode: CustomStringConvertible {
    public enum NetworkType: String, CaseIterable, CustomStringConvertible {
        case wpa, wep
        
        // MARK: CustomStringConvertible
        public var description: String {
            return rawValue.uppercased()
        }
    }
    
    public let data: Data
    
    public var string: String {
        return String(data: data, encoding: .ascii)!
    }
    
    public func image(color: CIColor? = nil, scale: UInt? = nil) -> CIImage {
        let scale: CGFloat = CGFloat(max(scale ?? 0, 1))
        return image.applyingFilter("CIFalseColor", parameters: [
            "inputColor0": color ?? .black,
            "inputColor1": .clear
        ]).transformed(by: CGAffineTransform(scaleX: scale, y: scale))
    }
    
    public init?(wifi ssid: String, password: String, networkType: NetworkType? = .wpa, isHidden: Bool? = nil) {
        guard !ssid.isEmpty else {
            return nil
        }
        self.init([
            "WIFI:S:\(ssid)",
            (networkType != nil ? "T:\(networkType!)" : ""),
            "P:\(password)",
            (isHidden != nil ? "H:\(isHidden!)" : ""),
            ""
        ].joined(separator: ";"))
    }
    
    public init?(url: URL) {
        self.init(url.absoluteString)
    }
    
    public init?(_ string: String) {
        guard !string.isEmpty,
              let data: Data = string.data(using: .ascii),
              let filter: CIFilter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let image: CIImage = filter.outputImage else {
            return nil
        }
        self.image = image
        self.data = data
    }
    
    private let image: CIImage
    
    // MARK: CustomStringConvertible
    public var description: String {
        return "\(string)"
    }
}
