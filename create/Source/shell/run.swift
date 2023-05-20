// Created by Leopold Lemmermann on 20.05.23.

import Foundation

extension Shell {
  @discardableResult
  static func run(_ commands: String...) throws -> String? {
    let pipe = Pipe()
    let task = Process()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.standardInput = nil
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.arguments = ["-c", commands.joined(separator: "; ")]
    
    do { try task.run() } catch { throw Error.running(error) }
    
    let output: String?
    
    do {
      output = try pipe.fileHandleForReading.readToEnd()
        .flatMap { String(data: $0, encoding: .utf8) }
    } catch {
      throw Error.fileHandle(error)
    }
    
    if task.terminationStatus == 0 {
      return output
    } else {
      throw Error.failed(output)
    }
  }
}
