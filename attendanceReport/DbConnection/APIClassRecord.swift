import Foundation

class APIClassRecord {
    static let shared = APIClassRecord()
    
    
    func updateClassRecord(id: String, classRecord: ClassRecord, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = "https://localhost:7207/api/ClassRecords/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            encoder.dateEncodingStrategy = .custom({ (date, encoder) in
                var container = encoder.singleValueContainer()
                let dateString = formatter.string(from: date)
                try container.encode(dateString)
            })
            
            let jsonData = try encoder.encode(classRecord)
            request.httpBody = jsonData
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON String: \(jsonString)")
            }
        } catch {
            completion(.failure(error))
            return
        }
            
            let task = URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    completion(.success(()))
                default:
                    completion(.failure(NSError(domain: "Server error", code: httpResponse.statusCode, userInfo: nil)))
                }
            }
            
            task.resume()
        }

    
    // GETS the classRecord from DB
    func getClassRecord(id: String, completionHandler: @escaping (Result<ClassRecord, Error>) -> Void) {
            let urlString = "https://localhost:7207/api/ClassRecords/\(id)"
            guard let url = URL(string: urlString) else {
                completionHandler(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    
                    // formatter that deals with converting datime to iso
                    let formatter = ISO8601DateFormatter()
                                formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                                    let container = try decoder.singleValueContainer()
                                    let dateStr = try container.decode(String.self)
                                    
                                    if let date = formatter.date(from: dateStr) {
                                        return date
                                    } else {
                                        throw DecodingError.dataCorruptedError(in: container,
                                                                               debugDescription: "Invalid date format: \(dateStr)")
                                    }
                                })
                    
                    
                    let classRecord = try decoder.decode(ClassRecord.self, from: data)
                        completionHandler(.success(classRecord))
                } catch {
                    completionHandler(.failure(error))
                }
            }
            task.resume()
        }
}
