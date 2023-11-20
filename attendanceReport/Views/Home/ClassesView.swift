import SwiftUI

struct ClassesView: View {
    @ObservedObject var studentViewModel: StudentViewModel

    var body: some View {
        let classes = studentViewModel.student?.enrolledClasses ?? ["No classes enrolled"]

        HStack {
            NavigationView {
                VStack(alignment: .leading) {
                    Text("Classes: ").font(.system(size: 23)).bold().padding()

                    List(classes, id: \.self) { className in
                        NavigationLink(destination: DetailsView(className: className)) {
                            Text(className)
                        }
                    }
                    .frame(height: CGFloat(classes.count) * 44)
                    .listStyle(PlainListStyle())
                }
            }
        }.frame(maxWidth: .infinity, alignment: .top)
    }
}

struct DetailsView: View {
    let className: String
    
    var body: some View {
        Text("Details for \(className)")
            .navigationBarTitle("Details", displayMode: .inline)
    }
}

// Preview
struct ClassesView_Previews: PreviewProvider {
    static var previews: some View {
        ClassesView(studentViewModel: StudentViewModel())
    }
}
