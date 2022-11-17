//	Created by Leopold Lemmermann on 16.11.22.

extension PackageCreator {
  func promptForName() -> String {
    while true {
      let input = readLine() ?? ""

      guard let name = getName(input) else {
        print(prompt: "Try again:\(kind == .service ? " ('Service' will be appended automatically)" : "")")
        continue
      }

      return name
    }
  }

  func getName(_ input: String) -> String? {
    guard let kind = kind else { return nil }

    // trimming trailing/leading newlings and removing spaces
    switch input
      .trimmingCharacters(in: .newlines)
      .replacing(" ", with: "")
    {
    // only allowing alphanumerics
    case let i where i.rangeOfCharacter(from: .alphanumerics.inverted) != nil:
      print(feedback: "You can only use alphanumeric characters...")
      return nil
    // disallowing first character to be a number
    case let i where i.first?.isNumber ?? false:
      print(feedback: "The first character must be a letter...")
      return nil
    // disallowing empty names
    case let i where i.isEmpty:
      print(feedback: "The name can't be empty...")
      return nil
    // confirming a short name
    case let i where i.count <= 4:
      print(feedback: "Are you sure you want to choose '\(i)'? ([y]es|[n]o)")
      let confirm = readLine() ?? "n"
      if confirm == "y" || confirm == "yes" { fallthrough }
      return nil
    case let i:
      switch kind {
      case .library: return i
      case .service: return i.appending("Service")
      }
    }
  }
}
