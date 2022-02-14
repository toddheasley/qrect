import SwiftUI
import PlaygroundSupport
import QRect

let qrCode: QRCode = QRCode("https://example.com")!
PlaygroundPage.current.setLiveView(Image(qrCode: qrCode, color: .primary, scale: 3)
    .padding())
