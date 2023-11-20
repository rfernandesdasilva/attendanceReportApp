import Foundation

struct User: Codable {
    let userEmail: String
    let userPassword: String

    
    // this is just to map the swift properties into JSON keys for the API
    enum CodingKeys: String, CodingKey {
        case userEmail = "userEmail"
        case userPassword = "userPassword"
    }
}
