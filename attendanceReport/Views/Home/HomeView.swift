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
    @ObservedObject var studentViewModel: StudentViewModel
    
    // State variables to handle the alert
        @State private var showAlert = false
        @State private var alertMessage = ""
        @State private var alertTitle = ""
        @State private var authSucessful = false
        
    
    var body: some View {
        
        if (authSucessful){
            
            
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0){
                        Text("Home").font(.title).bold().padding()
                        
                        CurrentClassesView()
                        DayScheduleView()
                        ClassesView(studentViewModel: studentViewModel)
                        
                        Button(action: {
                            authSucessful = false
                        }) {
                            Text("Logout")
                        }.padding(.top)
                        
                    } //.padding() // very important to visuals
                }
            }
        } else {
            LoginView(authSuccessful: $authSucessful, studentViewModel: studentViewModel)
        }
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let studentViewModel = StudentViewModel()
        HomeView(studentViewModel: studentViewModel)
    }
}

