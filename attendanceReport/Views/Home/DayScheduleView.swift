//
//  DayScheduleView.swift
//  attendanceReport
//
//  Created by Rafael Fernandes da Silva on 10/27/23.
//

// api call to get the classes you are, and the days they have classes
// get todays date and see if it matches
// if yes, show the class in the view

// tldr, we need to compare the time between right now and all the classes that are
// returned and add it to data structure to be displayed in the list

let sampleClassOne : [String] = ["testClass1", "testClass2", "testClass3"]
let sampleTimeStart = "09:30am"
let sampleTimeEnd = "04:30pm"

// use @state and timer. ask gpt
let timeUntilClass = "00:32 minutes"

import SwiftUI

struct DayScheduleView: View {
    var body: some View {
            
        VStack (alignment: .leading, spacing: -15){
            Text("Today's Schedule: ").font(.system(size: 23)).bold().padding()
            
            HStack{
                Text("Time until next class: ")
                Spacer()
                Text(timeUntilClass)
            }.padding()
            List {
                ForEach(sampleClassOne, id: \.self) { className in
                    VStack(alignment: .leading) {
                        Text(className)
                        
                        HStack{
                            Text("StartTime: " + sampleTimeStart).font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("EndTime: " + sampleTimeEnd).font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }.padding(.vertical)
                    
                }
            }
            // this is not very intelligent.
            // need to figure a way to size it properly
            .frame(height: CGFloat(sampleClassOne.count) * 97)
            .listStyle(PlainListStyle()).scrollDisabled(true)
        }
    }
}

#Preview {
    DayScheduleView()
}
