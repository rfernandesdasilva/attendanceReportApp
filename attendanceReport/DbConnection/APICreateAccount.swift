//
//  APILogin.swift
//  attendanceReport
//
//  Created by Rafael Fernandes da Silva on 11/13/23.
//

import Foundation


class APICreateAccount {
    
    // gets user by email for auth
    func createStudent(student: Student, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://localhost:7207/api/Student") else {
            completionHandler(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(student)
            request.httpBody = jsonData
        } catch {
            completionHandler(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                // You can handle different status codes here
                completionHandler(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server responded with an error"])))
                return
            }

            completionHandler(.success(()))
        }
        task.resume()
    }
}
