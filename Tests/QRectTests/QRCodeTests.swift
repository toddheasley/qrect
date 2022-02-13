import XCTest
@testable import QRect

final class QRCodeTests: XCTestCase {
    func testASCII() {
        XCTAssertEqual(QRCode("Example")?.ascii, "Example")
    }
    
    func testImage() {
        XCTAssertEqual(QRCode("https://example.com")?.image(scale: 1).extent, CGRect(x: 0.0, y: 0.0, width: 27.0, height: 27.0))
        XCTAssertEqual(QRCode("https://example.com")?.image(scale: 0).extent, CGRect(x: 0.0, y: 0.0, width: 27.0, height: 27.0))
        XCTAssertEqual(QRCode("https://example.com")?.image().extent, CGRect(x: 0.0, y: 0.0, width: 27.0, height: 27.0))
        XCTAssertEqual(QRCode("Example")?.image(scale: 5).extent, CGRect(x: 0.0, y: 0.0, width: 115.0, height: 115.0))
        XCTAssertEqual(QRCode("Example")?.image(scale: 2).extent, CGRect(x: 0.0, y: 0.0, width: 46.0, height: 46.0))
        XCTAssertEqual(QRCode("Example")?.image().extent, CGRect(x: 0.0, y: 0.0, width: 23.0, height: 23.0))
    }
    
    func testWIFIInit() {
        XCTAssertEqual(QRCode(wifi: "Example", password: "P@$$w0rd")?.ascii, "WIFI:S:Example;T:WPA;P:P@$$w0rd;;")
        XCTAssertEqual(QRCode(wifi: "Example", password: "password", networkType: .wep, isHidden: true)?.ascii, "WIFI:S:Example;T:WEP;P:password;H:true;")
        XCTAssertEqual(QRCode(wifi: "Example", password: "", networkType: nil, isHidden: false)?.ascii, "WIFI:S:Example;;P:;H:false;")
        XCTAssertNil(QRCode(wifi: "", password: "P@$$w0rd"))
    }
    
    func testURLInit() {
        XCTAssertEqual(QRCode(url: URL(string: "https://example.com")!)?.ascii, "https://example.com")
    }
    
    func testASCIIInit() {
        XCTAssertEqual(QRCode("Example")?.ascii, "Example")
        XCTAssertNil(QRCode("👍"))
        XCTAssertNil(QRCode(""))
    }
}
