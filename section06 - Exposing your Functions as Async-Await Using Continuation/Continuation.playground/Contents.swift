import UIKit

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

struct Post: Decodable {
    let title: String
}

func getPosts(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        completion(.failure(NetworkError.badURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else {
            completion(.failure(NetworkError.noData))
            return
        }
        
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        completion(.success(posts ?? []))
    }.resume()
}

//getPosts { result in
//    switch result {
//    case .success(let posts):
//        print(posts)
//    case .failure(let error):
//        print(error)
//    }
//}

func getPosts() async throws -> [Post] {
    return try await withCheckedThrowingContinuation { continuation in
        getPosts { result in
            switch result {
            case .success(let posts):
                continuation.resume(returning: posts)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
    }
}

Task {
    do {
        let posts = try await getPosts()
        print(posts)
    } catch {
        print(error)
    }
}
