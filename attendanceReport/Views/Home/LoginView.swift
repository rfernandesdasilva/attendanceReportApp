import SwiftUI

struct LoginView: View {
    
    @Binding var authSuccessful : Bool
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                Text("attendanceApp")
                    .font(.largeTitle)
                    .padding()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: loginAction) {
                    Text("Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                
                NavigationLink(destination: CreateAccountView()) {
                                    Text("Create account")
                }.padding()
                
            }
            .padding()
        }
    }

    func loginAction() {
        // Implement your login logic here
        print("Username: \(username), Password: \(password)")
        authSuccessful = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        @State var authSuccessful = false
        LoginView(authSuccessful: $authSuccessful)
    }
}
