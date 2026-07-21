import Foundation
import Observation

@Observable
@MainActor
final class NewsArticleListViewModel {
     var newsArticles: [NewsArticleViewModel] = []
    
    func getNewsBy(sourceId: String) async -> Void {
        do {
            let newsArticle: [NewsArticle] = try await WebService.shared.fetchNews(by: sourceId, url: Constants.Urls.topHeadLines(by: sourceId))
            self.newsArticles = newsArticle.map(NewsArticleViewModel.init)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct NewsArticleViewModel {
    let id: UUID = UUID()
    fileprivate let newsArticle: NewsArticle
    
    var author: String {
        get { return newsArticle.author ?? "" }
    }
    
    var title: String {
        get { return newsArticle.title ?? "" }
    }
    
    var description: String {
        get { return newsArticle.description ?? "" }
    }
    
    var urlToImage: URL? {
        get { return URL(string: newsArticle.urlToImage ?? "") }
    }
}
