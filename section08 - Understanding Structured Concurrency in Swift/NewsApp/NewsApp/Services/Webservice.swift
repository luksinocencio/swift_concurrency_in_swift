import Foundation

final class WebService {
    static let shared: WebService = WebService()
    
    private init() {}
    
    func fetchSources(url: URL?, completion: @escaping @Sendable (Result<[NewsSource], NetworkError>) -> Void) -> Void {
        guard let url: URL = url else {
            completion(.failure(.badUrl))
            return
        }
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data: Data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            let newsSourceResponse: NewsSourceResponse? = try? JSONDecoder().decode(NewsSourceResponse.self, from: data)
            completion(.success(newsSourceResponse?.sources ?? []))
        }
        
        task.resume()
    }
    
    func fetchNewsAsync(sourceId: String, url: URL?) async throws -> [NewsArticle] {
        try await withCheckedThrowingContinuation { continuation in
            fetchNews(sourceId: sourceId, url: url) { result in
                switch result {
                case .success(let newsArticles):
                    continuation.resume(returning: newsArticles)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchNews(sourceId: String, url: URL?, completion: @escaping @Sendable (Result<[NewsArticle], NetworkError>) -> Void) -> Void {
        guard let url: URL = url else {
            completion(.failure(.badUrl))
            return
        }
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data: Data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            let newsArticleResponse: NewsArticleResponse? = try? JSONDecoder().decode(NewsArticleResponse.self, from: data)
            completion(.success(newsArticleResponse?.articles ?? []))
        }
        
        task.resume()
    }
}
