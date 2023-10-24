//
//  HomeView.swift
//  attendanceReport
//
//  Created by Rafael Fernandes da Silva on 10/24/23.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    // the auth class that deals with biometrics
    // that I created
    private var authManager = AuthenticationManager()
    
    // State variables to handle the alert
        @State private var showAlert = false
        @State private var alertMessage = ""
        @State private var alertTitle = ""
    
    var body: some View {
        VStack {
            Text("Welcome to !")
                .padding()
            
            Button("Authenticate") {
                authManager.authenticateUser { success, error in
                    if success {
                        alertTitle = "Success"
                        alertMessage = "Authentication succeeded!"
                    } else {
                        alertTitle = "Error"
                        alertMessage = error?.localizedDescription ?? "An unknown error occurred"
                    }
                    showAlert = true
                }
            }
            
            .alert(isPresented: $showAlert) {
                            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
        }
    }
}

#Preview {
    HomeView()
}

