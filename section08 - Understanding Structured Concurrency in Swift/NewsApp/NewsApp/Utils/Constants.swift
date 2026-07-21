import Foundation

struct Constants {
    static let apiKey = "d398c2650c89495793db74ac96b35e83"
    private static let baseUrl = "https://newsapi.org/v2"

    struct Urls {
        static let sources: URL? = URL(string: "\(Constants.baseUrl)/top-headlines/sources?apiKey=\(apiKey)")

        static func topHeadLines(by sourceId: String) -> URL? {
            return URL(string: "\(Constants.baseUrl)/top-headlines?sources=\(sourceId)&apiKey=\(apiKey)")
        }
    }
}
