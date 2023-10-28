//
//  CurrentClassesView.swift
//  attendanceReport
//
//  Created by Rafael Fernandes da Silva on 10/24/23.
//

import SwiftUI

struct CurrentClassesView: View {
    
    let upcomingClassName = "SDV4416"
    let upcomingClassStartTime = "08:30pm"
    let upcomingClassEndTime = "12:30am"
    let dateTime = "11/22/33"
    
    var body: some View {
        VStack(alignment: .leading) {
    
            // Currently needs to find a way out to orient without the space between
            // so the class name will be always on the right
            Text("Upcoming Class: ").font(.system(size: 23)).bold()
            Text(upcomingClassName).font(.system(size: 23)).bold()
            
            // HStack is for information under Upcoming Class
            HStack{
                
                // I have an insane brain
                // this VStack is just for the start end time
                
                // leading makes the two texts align
                VStack (alignment: .leading){
                    Text("Starts at: \(upcomingClassStartTime)").font(.system(size:16))
                    Text("Ends at: \(upcomingClassEndTime)").font(.system(size:16))
                }
                
                Spacer()
                Text(dateTime).font(.system(size:16))
            }
            
            // HStack for buttons
            HStack{
                
                // Should call faceId, Location services and open camera for QR Code
                // if all is good, apirequest to mark attendance
                Button(action:  {
                    print("tempButtonAction")
                }) {
                    Text("Mark Attendance")
                        .font(.system(size:22))
                        .frame(width:250, height:50)
                        .background(Color.blue) // Color is different from color
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Button(action: {
                    print("tempContactProfessorButtonAction")
                }) {
                    Text("Contact Professor")
                }
                
            }
        } .padding()
    }
}

#Preview {
    CurrentClassesView()
}
