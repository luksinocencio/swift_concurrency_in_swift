import Foundation

struct RandomImage: Decodable {
    let image: Data
    let randomQuote: RandomQuote
}

struct RandomQuote: Decodable {
    let quote: String
    let author: String
}
