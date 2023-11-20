import SwiftUI

struct CreateAccountView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    
    private let apiConnection = APICreateAccount()

    var body: some View {
        NavigationView {
            VStack {
                Text("Create Account")
                    .font(.largeTitle)
                    .padding()

                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: createAccountAction) {
                    Text("Create Account")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }

    func createAccountAction() {
        // Implement your account creation logic here
        print("Name: \($firstName), Name: \($lastName), Email: \(email), Password: \(password), Confirm Password: \(confirmPassword)")
        
        // create student here to send to createStudent
        let newUser = User(userEmail: email, userPassword: password)
        
        var devices: [String] = []
        
        if let deviceID = UIDevice.current.identifierForVendor?.uuidString {
            devices.append(deviceID)
        } else {
            // Handle the case where the device ID couldn't be retrieved
            print("Device ID could not be retrieved")
        }
        
        let newStudent = Student(userId: generateHexadecimalString(length: 24), studentFirstName: firstName, studentLastName: lastName, enrolledClasses: [], user: newUser, authorizedDevices: devices)
        
        apiConnection.createStudent(student: newStudent) { result in
            switch result {
            case .success:
                print("Account created successfully")
                // Handle success, such as updating authSuccessful state or navigating to another view
                
            case .failure(let error):
                print("Error creating account: \(error)")
                // Handle failure, such as showing an error message to the user
            }
        }
    }

    
    func generateHexadecimalString(length: Int) -> String {
        let letters = "0123456789abcdef"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
