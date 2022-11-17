//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

public struct CreatePackage {
  var kind = Kind.library,
      names = ["", ""],
      dir = FileManager.default.homeDirectoryForCurrentUser

  public init() {}

  public mutating func run(_ arguments: [String] = CommandLine.arguments) {
    do {
      try runWithError(arguments)
    } catch {
      print(feedback: "Oops... Something went wrong: \(error)")
    }
  }

  mutating func runWithError(_ arguments: [String]) throws {
    if arguments.contains("-l") || arguments.contains("--library") {
      kind = .library
    } else if arguments.contains("-s") || arguments.contains("--service") {
      kind = .service
    } else {
      print(prompt: "What type of package do you want to create? ([l]ibrary|[s]ervice)")
      kind = promptForKind()
      print(feedback: "You chose to create a \(kind).\n")
    }

    let serviceSuffix = kind == .service ? " ('Service' will be appended automatically)" : ""
    if
      let index = arguments.firstIndex(of: "-n") ?? arguments.firstIndex(of: "--name"),
      let input = arguments[safe: index + 1],
      let name = getName(input)
    {
      names[0] = name
    } else {
      print(prompt: "What is your \(kind) gonna be called?\(serviceSuffix)")
      names[0] = promptForName()
      print(feedback: "Your \(kind) will be called '\(names[0])'.\n")
    }

    if kind == .service {
      if
        let index = arguments.firstIndex(of: "-in") ?? arguments.firstIndex(of: "--implementationName"),
        let input = arguments[safe: index + 1],
        let name = getName(input)
      {
        names[1] = name
      } else {
        print(prompt: "What is your \(kind)'s implementation gonna be called?\(serviceSuffix)")
        names[1] = promptForName()
        print(feedback: "Your \(kind)'s implementation will be called '\(names[1])'.\n")
      }
    }

    if
      let index = arguments.firstIndex(of: "-d") ?? arguments.firstIndex(of: "--directory"),
      let url = getDir(arguments[safe: index + 1] ?? "")
    {
      dir = url
    } else {
      print(prompt: "Where would you like to create the \(kind)? (leave blank for home)")
      dir = promptForDir()
      print(feedback: "Your \(kind) will be created in '\(dir.path())'.")
    }

    print(feedback: "Starting creation...")
    try cloneRepo()
    try rename()
    try initGit()
    print(feedback: "Your new \(kind) is ready at \(dir.appending(component: names[0]).path())")
    
    try openXcode()
  }
}
