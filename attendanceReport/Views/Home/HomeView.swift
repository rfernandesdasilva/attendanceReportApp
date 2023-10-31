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
    
    // State variables to handle the alert
        @State private var showAlert = false
        @State private var alertMessage = ""
        @State private var alertTitle = ""
    
    var body: some View {
    
        // NavigationStack allows me to show a new view over it
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0){
                    Text("Home").font(.title).bold().padding()
                    
                    CurrentClassesView()
                    DayScheduleView()
                    ClassesView()
                        
                    // the following code lets me create tabs to switch from views.
                    // currently in need to figure out how to show staticly in the home
                    
                    /*TabView {
                     Text("temp").tabItem {
                     Label("page2", systemImage: "2.square.fill")
                     }
                     } */
                    
                }//.padding() // very important to visuals
            }
        }
        
        
        
    }
}

#Preview {
    HomeView()
}

