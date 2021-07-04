import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension FileManager {
    func executeOnContentsOf(path: String, action: (_ item: String) -> Void) {
        let enumerator = self.enumerator(atPath: path)
        while let item = enumerator?.nextObject() as? String {
            action(item)
        }
    }
}

public extension String {
    var expandingTildeInPath: String {
        get { NSString(string: self).expandingTildeInPath }
    }
}
