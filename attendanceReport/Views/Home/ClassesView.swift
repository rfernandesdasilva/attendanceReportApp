//
//  ClassesView.swift
//  attendanceReport
//
//  Created by Rafael Fernandes da Silva on 10/24/23.
//

import SwiftUI

// TODO: figure out how to use fullScreenCover in this, and change the screen when we select a class

struct ClassesView: View {
    var body: some View {
        
        let classes: [String] = ["testClass1", "testClass2", "testClass3"]
        
        // vertical stack that contains the list of classes.
        // classes should be clickable
        HStack{
            NavigationView { // the problem is the navigationView
                VStack (alignment: .leading){
                    
                    Text("Classes: ").font(.system(size: 23)).bold().padding()
                    
                    // for each class in the list we receiveå, we create a new line
                    List {
                        ForEach(classes, id: \.self) { className in
                            
                            // navigation link allows me to make the list clickable
                            // TODO: should we go to a different view to view classes?
                            
                            // sending className as a title for the new view
                            NavigationLink(destination: DetailsView(className: className)) {
                                Text(className)
                            }
                        }
                    }
                    // The ScrollView expects dimension from content, but List expects dimension from container - as you see there is conflict, so size for list is undefined, and a result rendering engine just drop it to avoid disambiguty.
                    
                    .frame(height: CGFloat(classes.count) * 44)
                    .listStyle(PlainListStyle())
                    
                }
            }
        }.frame(maxWidth: .infinity, alignment: .top)
    }
}

// TODO: actual detailed schedule done

struct DetailsView: View {
    let className: String
    
    var body: some View {
        Text("Details for \(className)")
            .navigationBarTitle("Details", displayMode: .inline)
    }
}


#Preview {
    ClassesView()
}
