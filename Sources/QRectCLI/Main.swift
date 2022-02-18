import Cocoa
import ArgumentParser
import QRect

@main
struct Main: ParsableCommand {
    @Argument(help: "Provide ASCII string to encode.")
    var code: QRCode
    
    @Option(name: .shortAndLong,  help: "Scale output image.")
    var scale: UInt = 1
    
    @Flag(name: .shortAndLong, help: "Open with Finder.")
    var open: Bool = false
    
    @Flag(name: .shortAndLong, help: "Show in Finder.")
    var finder: Bool = false
    
    // MARK: ParsableCommand
    static var configuration = CommandConfiguration(commandName: "\(Bundle.main.executableURL!.lastPathComponent)",
        abstract: "Save a QR code of any ASCII string to the working directory as transparent PNG.")
    
    func run() throws {
        guard let data: Data = NSImage(qrCode: code, scale: scale).pngData() else {
            throw URLError(.cannotCreateFile)
        }
        print("Encode string \"\(code.string)\"")
        let suffix: String = scale > 1 ? "@\(scale)x" : ""
        guard let string: String = code.string.fileName,
            let url: URL = URL(string: "\(string)\(suffix).png", relativeTo: .currentDirectory) else {
            throw URLError(.badURL)
        }
        try data.write(to: url)
        print("Save file \"\(url.lastPathComponent)\"")
        if open {
            print("Open with Finder…")
            NSWorkspace.shared.open(url)
        }
        if finder {
            print("Show in Finder…")
            NSWorkspace.shared.open(.currentDirectory)
        }
    }
}

extension QRCode: ExpressibleByArgument {
    
    // MARK: ExpressibleByArgument
    public init?(argument: String) {
        self.init(argument)
    }
}

private extension String {
    var fileName: Self? {
        return replacingOccurrences(of: ":", with: "_")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "?", with: "_")
            .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
    }
}

private extension URL {
    static var currentDirectory: Self {
        return Self(fileURLWithPath: FileManager.default.currentDirectoryPath)
    }
}
