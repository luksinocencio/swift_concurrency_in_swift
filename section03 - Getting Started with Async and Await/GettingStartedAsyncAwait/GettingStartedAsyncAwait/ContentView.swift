import SwiftUI

struct CurrentDate: Decodable, Identifiable, Hashable {
    let id = UUID()
    let date: String
    
    private enum CodingKeys: String, CodingKey {
        case date = "date"
    }
}

struct ContentView: View {
    @State private var currentDates: [CurrentDate] = []
    
    private func getDate() async throws -> CurrentDate? {
        guard let url = URL(string: "http://localhost:3000/current-date") else {
            fatalError("Url is invalid")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
    
    private func populateDates() async {
        do {
            guard let currentData = try await getDate() else { return }
            currentDates.append(currentData)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationView {
            List(currentDates) { currentDate in
                Text("\(currentDate.date)")
            }.listStyle(.plain)
            
            .navigationTitle("Dates")
            .navigationBarItems(trailing: Button(action: {
                Task { await populateDates() }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            .tint(.teal)
            .task {
                await populateDates()
            }
        }
    }
}

#Preview {
    ContentView()
}
