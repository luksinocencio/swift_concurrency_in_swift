import Foundation
import Observation

@Observable
@MainActor
final class NewsSourceListViewModel {
    var newsSources: [NewsSourceViewModel] = []
    var isLoading: Bool = false
    
    private func withLoading(_ execute: @escaping () async -> Void) async -> Void {
        guard (!isLoading) else { return }
        isLoading = true
        defer { isLoading = false }
        
        await execute()
    }
    
    func getSources() async -> Void {
        await withLoading {
            do {
                let newsSources: [NewsSource] = try await WebService.shared.fetchSources(url: Constants.Urls.sources)
                self.newsSources = newsSources.map(NewsSourceViewModel.init)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct NewsSourceViewModel {
    fileprivate var newsSource: NewsSource
    
    var id: String {
        get { return newsSource.id }
    }
    
    var name: String {
        get { return newsSource.name }
    }
    
    var description: String {
        get { return newsSource.description }
    }
    
    static var `default`: NewsSourceViewModel {
        let newsSource = NewsSource(id: "abc-news", name: "ABC News", description: "This is ABC News")
        return NewsSourceViewModel(newsSource: newsSource)
    }
}
