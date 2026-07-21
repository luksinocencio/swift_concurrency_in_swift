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
    
    func fetchNews(by sourceId: String, url: URL?, completion: @escaping @Sendable (Result<[NewsArticle], NetworkError>) -> Void) -> Void {
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
