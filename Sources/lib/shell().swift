//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

@discardableResult
func shell(_ command: String) throws -> String? {
//  #if DEBUG
//  print("Running shell command:\n\t'\(command)'\n")
//  return nil
//  #else
  let task = Process()
  let pipe = Pipe()

  task.standardOutput = pipe
  task.standardError = pipe
  task.arguments = ["-c", command]
  task.executableURL = URL(fileURLWithPath: "/bin/zsh")
  task.standardInput = nil

  try task.run()

  let data = pipe.fileHandleForReading.readDataToEndOfFile()

  return String(data: data, encoding: .utf8)
//  #endif
}
