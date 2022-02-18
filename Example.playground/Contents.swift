import PlaygroundSupport
import SwiftUI
import QRect

let qrCode: QRCode = QRCode("https://example.com")!

PlaygroundPage.current.setLiveView(Image(qrCode: qrCode, color: .primary, scale: 3)
    .padding())

/*
import Cocoa

let image: NSImage = NSImage(qrCode: qrCode, color: .textColor, scale: 3)
PlaygroundPage.current.setLiveView(NSImageView(image: image)) */
