import Foundation

struct ClassRecord: Codable {
    let classRecordId: String
    let courseId: String
    let recordCreationTime: Date
    let recordClosureTime: Date
    var classOnTimeStudents: [String]
    var classLateStudents: [String]

    
    // this is just to map the swift properties into JSON keys for the API
    enum CodingKeys: String, CodingKey {
        case classRecordId = "ClassRecordId"
        case courseId = "CourseId"
        case recordCreationTime = "RecordCreationTime"
        case recordClosureTime = "RecordClosureTime"
        case classOnTimeStudents = "ClassOnTimeStudents"
        case classLateStudents = "ClassLateStudents"
    }
}
