import Foundation

class StudentViewModel: ObservableObject {
    @Published var student: Student?

    private let apiConnection = APILogin()

    func authenticateUser(userEmail: String, userPassword: String, completion: @escaping (Bool) -> Void) {
        apiConnection.authenticateUser(userEmail: userEmail, userPassword: userPassword) { result in
            DispatchQueue.main.async { // Ensure UI updates are on the main thread
                switch result {
                case .success(let fetchedStudent):
                    if fetchedStudent.user.userPassword == userPassword {
                        self.student = fetchedStudent
                        completion(true)
                    } else {
                        completion(false)
                    }

                case .failure(_):
                    completion(false)
                }
            }
        }
    }
}
