//	Created by Leopold Lemmermann on 16.11.22.

extension PackageCreator {
  func promptForKind() -> Kind {
    while true {
      let input = readLine() ?? "l"
      
      guard let kind = getKind(input) else {
        print(feedback: "Unknown type...")
        print(prompt: "Please try again: ([l]ibrary|[s]ervice)")
        continue
      }
      
      return kind
    }
  }
  
  func getKind(_ input: String) -> Kind? {
    switch input {
    case "l", "library":
      return .library
    case "s", "service":
      return .service
    default:
      return nil
    }
  }
}
