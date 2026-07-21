import Foundation

extension WebService {
    func fetchSources(url: URL?) async throws -> [NewsSource] {
        guard let url: URL = url else { throw NetworkError.badUrl }

        let (data, _): (Data, URLResponse) = try await URLSession.shared.data(from: url)

        guard let newsSourceResponse = try? JSONDecoder().decode(NewsSourceResponse.self, from: data) else {
            throw NetworkError.decodingError
        }

        return newsSourceResponse.sources
    }

    func fetchNews(by sourceId: String, url: URL?) async throws -> [NewsArticle] {
        return try await withCheckedThrowingContinuation { continuation in
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
}
