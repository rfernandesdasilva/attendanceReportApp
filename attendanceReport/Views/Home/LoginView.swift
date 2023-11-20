import SwiftUI


struct LoginView: View {
    
    @Binding var authSuccessful : Bool
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingLoginFailedAlert = false
    
    @ObservedObject var studentViewModel: StudentViewModel // shared data
    
    private let apiConnection = APILogin()

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
                .alert(isPresented: $showingLoginFailedAlert) {
                    Alert(title: Text("Login Failed"), message: Text("Please check your credentials and try again."), dismissButton: .default(Text("OK")))
                }
                
                NavigationLink(destination: CreateAccountView()) {
                                    Text("Create account")
                }.padding()
                
            }
            .padding()
        }
    }

    func loginAction() {
        studentViewModel.authenticateUser(userEmail: username.lowercased(), userPassword: password) { success in
            if success {
                authSuccessful = true
            } else {
                showingLoginFailedAlert = true
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        @State var authSuccessful = false
        let studentViewModel = StudentViewModel()
        LoginView(authSuccessful: $authSuccessful, studentViewModel: studentViewModel) // pass it to LoginView
    }
}

