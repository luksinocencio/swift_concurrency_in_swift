import SwiftUI

struct NewsSourceListView: View {
    var newsSourceListViewModel: NewsSourceListViewModel = NewsSourceListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if newsSourceListViewModel.isLoading {
                    VStack {
                        Spacer()
                        ProgressView()
                            .scaleEffect(1.0)
                        Spacer()
                    }
                } else {
                    List(newsSourceListViewModel.newsSources, id: \.id) { newsSource in
                        NavigationLink {
                            NewsListView(newsSource: newsSource)
                        } label: {
                            NewsSourceCell(newsSource: newsSource)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .task {
                await newsSourceListViewModel.getSources()
            }
            .navigationTitle(Text("News Sources"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task {
                            await newsSourceListViewModel.getSources()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                    .disabled(newsSourceListViewModel.isLoading)
                }
            }
        }
    }
}

struct NewsSourceCell: View {
    
    let newsSource: NewsSourceViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(verbatim: newsSource.name)
                .font(.headline)
            Text(verbatim: newsSource.description)
        }
    }
}

#Preview {
    NewsSourceListView()
}
