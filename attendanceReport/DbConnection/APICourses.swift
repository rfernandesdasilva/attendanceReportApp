//
//  APICourses.swift
//  attendanceReport
//
//  Created by Rafael Fernandes da Silva on 11/19/23.
//

import Foundation

class APICourses {
    
    func fetchCourseById(courseId: String, completionHandler: @escaping (Result<Course, Error>) -> Void) {
        let urlString = "https://localhost:7207/api/Courses/\(courseId)"
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
                let course = try decoder.decode(Course.self, from: data)
                completionHandler(.success(course))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}
