import Foundation

struct Course: Codable {
    let courseId: String
    let className: String
    let classStartTime: Date
    let classEndTime: Date
    let classTermStart: Date
    let classTermEnd: Date
    var classStudentIds: [String]

    
    // this is just to map the swift properties into JSON keys for the API
    enum CodingKeys: String, CodingKey {
        case courseId = "courseId"
        case className = "className"
        case classStartTime = "classStartTime"
        case classEndTime = "recordClosureTime"
        case classTermStart = "classTermStart"
        case classTermEnd = "classTermEnd"
        case classStudentIds = "classStudentIds"
    }
}
