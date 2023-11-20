//
//  attendanceReportApp.swift
//  attendanceReport
//
//  Created by Rafael Fernandes da Silva on 10/16/23.
//

import SwiftUI

@main
struct attendanceReportApp: App {
    @StateObject var studentViewModel = StudentViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView(studentViewModel: studentViewModel)
        }
    }
}
