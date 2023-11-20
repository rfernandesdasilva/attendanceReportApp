import Foundation

struct Student: Codable {
    let userId: String
    let studentFirstName: String
    let studentLastName: String
    var enrolledClasses: [String]
    var user: User
    var authorizedDevices: [String]

    
    // this is just to map the swift properties into JSON keys for the API
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case studentFirstName = "studentFirstName"
        case studentLastName = "studentLastName"
        case enrolledClasses = "enrolledClasses"
        case user = "user"
        case authorizedDevices = "authorizedDevices"
    }
}
