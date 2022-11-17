//	Created by Leopold Lemmermann on 16.11.22.

extension Collection {
  subscript(safe index: Index) -> Iterator.Element? {
    index >= startIndex && index < endIndex ? self[index] : nil
  }
}
