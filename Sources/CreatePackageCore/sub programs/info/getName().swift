//	Created by Leopold Lemmermann on 16.11.22.

extension CreatePackage {
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
    if input.count > 3 {
      return kind == .service ?
        input.appending("Service") :
        input
    } else if input.isEmpty {
      print(feedback: "You have to specify a name...")
      return nil
    } else {
      print(feedback: "Are you sure you want to choose '\(input)'? ([y]es|[n]o)")
      let confirm = readLine() ?? "n"
      if confirm == "y" || confirm == "yes" {
        return kind == .service ?
          input.appending("Service") :
          input
      }
      else { return nil }
    }
  }
}
