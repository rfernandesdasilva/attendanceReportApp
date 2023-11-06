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
    
    let templateClassRecordId = "fbec47000f6baef77322d359"
    let templateStudentId = "7388bf744fe2905c545e9546"
    
    // State variable to track authentication status
    // if authentication is sucessfull, change to true and
    // change the appearence of button and make the API call
    @State private var isAuthenticated = false
    
    // Instance of AuthFaceId
    private let authFaceId = AuthFaceId()
    
    // get and put
    private let apiConnection = APIClassRecord()

    
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
                // Should call faceId, Location services and open camera for QR Code
                // if all is good, apirequest to mark attendance
                Button(action:  {
                        // Call Face ID authentication
                        authFaceId.authenticateUser { success, error in
                        if success {
                        // Handle success
                            isAuthenticated = true
                            print("Authentication successful")
                            
                            // if sucessfull, proceed to api call
                            apiConnection.getClassRecord(id: templateClassRecordId) { result in
                                switch result {
                                case .success(var classRecord):
                                    print("Class record: \(classRecord)")
                                    
                                    classRecord.classOnTimeStudents.append(templateStudentId)
                                    
                                    apiConnection.updateClassRecord(id: classRecord.classRecordId, classRecord: classRecord) { result in
                                            switch result {
                                            case .success:
                                                print("Class record updated successfully")
                                            case .failure(let error):
                                                print("Error updating class record: \(error)")
                                            }
                                        }
                                    
                                case .failure(let error):
                                    print("Error fetching class record: \(error)")
                                }
                            }
                            
                        } else if let error = error {
                                        // Handle error
                            print("Authentication failed with error: \(error)")
                        } else {
                        // Handle failure
                            print("Authentication failed")
                        }
                    } 
                }) {
                    if (isAuthenticated == true){
                        Text("Done!")
                            .font(.system(size:22))
                            .frame(width:250, height:50)
                            .background(Color.green) // Color is different from color
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    } else {
                        Text("Mark Attendance")
                            .font(.system(size:22))
                            .frame(width:250, height:50)
                            .background(Color.blue) // Color is different from color
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

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
