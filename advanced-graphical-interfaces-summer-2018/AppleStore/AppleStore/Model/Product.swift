import Foundation

struct Product: Codable {
    let title: String
    let description: String
    let category: Category
    let startingPrice: String
    let imageURL: String
    let discoverURL: String
}
