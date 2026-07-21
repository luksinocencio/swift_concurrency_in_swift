import UIKit

let paths = Bundle.main.paths(forResourcesOfType: "txt", inDirectory: nil)
let fileHandle = FileHandle(forReadingAtPath: paths[0])

Task {
    for try await line in fileHandle!.bytes {
        print(line)
    }
}
