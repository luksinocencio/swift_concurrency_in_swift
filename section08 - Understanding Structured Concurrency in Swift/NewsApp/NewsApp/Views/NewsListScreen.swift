import SwiftUI

struct NewsListScreen: View {
    let newsSource: NewsSourceViewModel
    var newsArticleListViewModel: NewsArticleListViewModel = NewsArticleListViewModel()
    
    var body: some View {
        List(newsArticleListViewModel.newsArticles, id: \.id) { newsArticle in
            NewsArticleCell(newsArticle: newsArticle)
        }
        .listStyle(.plain)
        .task {
            await newsArticleListViewModel.getNewsBy(sourceId: newsSource.id)
        }
        .navigationTitle(newsSource.name)
    }
}

struct NewsArticleCell: View {
    
    let newsArticle: NewsArticleViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: newsArticle.urlToImage) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView("Loading...")
                    .frame(width: 100, height: 100)
            }
            
            VStack {
                Text(verbatim: newsArticle.title)
                    .fontWeight(.bold)
                Text(verbatim: newsArticle.description)
            }
        }
    }
}

#Preview {
    NewsListScreen(newsSource: NewsSourceViewModel.default)
}
