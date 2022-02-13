import Foundation
import ArgumentParser
import QRect

@main
struct Main: ParsableCommand {
    
    // MARK: ParsableCommand
    static var configuration = CommandConfiguration(commandName: "\(Bundle.main.executableURL!.lastPathComponent)",
        abstract: "Generate QR code.")
    
    func run() throws {
        print("QRect")
    }
}
