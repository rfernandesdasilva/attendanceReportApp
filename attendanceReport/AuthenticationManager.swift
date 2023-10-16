// authentication import file that has biometrics
import LocalAuthentication

class AuthenticationManager {
    
    // completion in this method is a "closure" parameter. when completed, it receives
    // a boolean true or false for success and failure, and an error if any is found
    
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        
        // authentication context
        let context = LAContext()
        
        // canEvaluatePolicy checks if the device currently has capabilities to access biometrics
        // If the device doesn't support biometrics or if there's another issue (like biometrics being locked out due to too many failed attempts), the method will return false and populate the error variable.
        
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            // we get inside this conditional once the system is checked: it is possible to do biometrics
            
            //.deviceOwnerAuthenticationWithBiometrics is the intent to utilize the auth via biometrics
            // localizedReason is a parameter that
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success, authenticationError)
                    print("Authentication done!")
                }
            }
        } else {
            
            // No biometrics available
            DispatchQueue.main.async {
                completion(false, error)
            }
        }
    }
}
