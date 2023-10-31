import Foundation

class APIClassRecord {
    static let shared = APIClassRecord()
    
    func updateClassRecord(id: String, classRecord: ClassRecord, completion: @escaping (Result<Void, Error>) -> Void) {
        let endpoint = "http://localhost:7207/api/ClassRecords/\(id)"
        guard let url = URL(string: endpoint) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(classRecord)
            request.httpBody = jsonData
        } catch {
            print("Error encoding class record: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 204 {
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "Server returned status code: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil)))
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
                    decoder.dateDecodingStrategy = .iso8601 // Assuming the dates are in ISO8601 format
                    let classRecord = try decoder.decode(ClassRecord.self, from: data)
                    completionHandler(.success(classRecord))
                } catch {
                    completionHandler(.failure(error))
                }
            }
            task.resume()
        }
}
