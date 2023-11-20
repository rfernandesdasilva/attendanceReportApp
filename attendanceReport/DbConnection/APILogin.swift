//
//  APILogin.swift
//  attendanceReport
//
//  Created by Rafael Fernandes da Silva on 11/13/23.
//

import Foundation


class APILogin {
    // GETS the classRecord from DB
    func authenticateUser(userEmail: String, userPassword: String, completionHandler: @escaping (Result<Student, Error>) -> Void) {
        let urlString = "https://localhost:7207/api/Student/ByEmail/\(userEmail)"
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
                        let students = try decoder.decode([Student].self, from: data)
                        if let firstStudent = students.first {
                            completionHandler(.success(firstStudent))
                        } else {
                            completionHandler(.failure(NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey: "No student found"])))
                        }
                    } catch {
                        completionHandler(.failure(error))
                    }
                }
        task.resume()
    }
}
