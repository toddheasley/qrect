import SwiftUI
import PlaygroundSupport
import QRect

PlaygroundPage.current.setLiveView(Image(qrCode: QRCode("https://example.com")!, scale: 3))
