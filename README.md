# ![QRect](QRect@3x.png)

`QRect` adds SwiftUI/AppKit/UIKit syntax sugar to the [QR code generator](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIQRCodeGenerator) built into `CoreImage`.

## Example Usage

```swift
import PlaygroundSupport
import SwiftUI
import QRect

var qrCode: QRCode = QRCode(url: URL(string: "https://example.com")!)!
print(qrCode) // https://example.com

qrCode = QRCode(wifi: "Abraham Linksys", password: "P@$$w0rd", networkType: .wpa)!
print(qrCode) // WIFI:S:Abraham Linksys;T:WPA;P:P@$$w0rd;;

qrCode = QRCode("https://example.com")!
print(qrCode) // https://example.com

PlaygroundPage.current.setLiveView(Image(qrCode: qrCode, color: .primary, scale: 3)
    .padding())
```

```swift
import Cocoa

let image: NSImage = NSImage(qrCode: qrCode, color: .textColor, scale: 3)
PlaygroundPage.current.setLiveView(NSImageView(image: image))
```

```swift
import UIKit

let image: UIImage = UIImage(qrCode: qrCode, color: .label, scale: 3)
PlaygroundPage.current.setLiveView(UIImageView(image: image))
```

## Command-Line Interface

`QRect` package includes `qrect-cli` for saving a QR code of any ASCII string to the working directory as
transparent PNG:

```zsh
toddheasley Desktop % ./qrect-cli "https://example.com" -fos 3
```

By default, the resulting QR code PNG will use the minimum number of pixels needed to encode the ASCII value -- always square and usually with an edge length of 23 or 27 pixels. Use `--scale` with an integer value greater than 1 to generate larger resolution PNGs:

## Requirements

Targets [iOS](https://developer.apple.com/ios)/[iPadOS](https://developer.apple.com/ipad)/[tvOS ](https://developer.apple.com/tvos) 15 and [macOS](https://developer.apple.com/macos) 12 Monterey. Written in [Swift](https://developer.apple.com/documentation/swift) 5.5 and builds in [Xcode](https://developer.apple.com/xcode) 13 or newer.
