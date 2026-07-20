import Foundation

class Webservice {
    func getDate() async throws -> CurrentDate? {
        guard let url = URL(string: "http://localhost:3000/current-date") else {
            fatalError("Url is invalid")
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
}
