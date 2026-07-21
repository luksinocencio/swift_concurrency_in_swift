import UIKit

func fetchThumbnails() async -> [UIImage] {
    return [UIImage()]
}

func updateUI() async {
    // get thumbnails
    let thumbnails = await fetchThumbnails()
    
    Task.detached(priority: .background) {
        writeToCache(images: thumbnails)
    }
    
//    Task(priority: .background) {
//        Task {
//            print(Task.currentPriority == .background)
//        }
//    }
}

private func writeToCache(images: [UIImage]) {
    // write to cache
}

Task {
    await updateUI()
}
