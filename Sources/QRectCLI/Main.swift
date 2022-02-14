import Cocoa
import ArgumentParser
import QRect

@main
struct Main: ParsableCommand {
    @Argument(help: "Specify string to encode.")
    var string: String = "Example"
    
    @Option(name: .shortAndLong,  help: "Scale output image.")
    var scale: UInt = 10
    
    // MARK: ParsableCommand
    static var configuration = CommandConfiguration(commandName: "\(Bundle.main.executableURL!.lastPathComponent)",
        abstract: "Generate QR code.")
    
    func run() throws {
        guard let qrCode: QRCode = QRCode(string) else {
            throw URLError(.cannotDecodeRawData)
        }
        guard let pngData: Data = NSImage(qrCode: qrCode, scale: scale).pngData() else {
            throw URLError(.cannotCreateFile)
        }
        guard let url: URL = URL(string: "code.png", relativeTo: Bundle.main.executableURL) else {
            throw URLError(.badURL)
        }
        try pngData.write(to: url)
    }
}
