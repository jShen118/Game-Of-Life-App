import SwiftUI

struct Templates: View {
    @Binding var colonyData: [Colony]
    @Binding var isAdding: Bool
    
    var body: some View {
        VStack {
            Text("Choose a Template")
            .font(.largeTitle)
            .padding()
            HStack {
                Button(action: {
                    self.isAdding.toggle()
                    self.colonyData.append(Colony("Enter New Colony Name", 60, []))
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .border(Color.black)
                            .frame(width: 250, height: 250)
                        Text("Blank").foregroundColor(Color.black)
                    }
                }
               Button(action: {
                   self.isAdding.toggle()
                   self.colonyData.append(Colony("Enter New Colony Name", 60, []))
               }) {
                   ZStack {
                       Rectangle()
                           .fill(Color.white)
                           .border(Color.black)
                           .frame(width: 250, height: 250)
                       Text("Basic").foregroundColor(Color.black)
                   }
               }
            }
            HStack {
                Button(action: {
                    self.isAdding.toggle()
                    self.colonyData.append(Colony("Enter New Colony Name", 60, []))
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .border(Color.black)
                            .frame(width: 250, height: 250)
                        Text("Glider").foregroundColor(Color.black)
                    }
                }
                Button(action: {
                    self.isAdding.toggle()
                    self.colonyData.append(Colony("Enter New Colony Name", 60, []))
                }) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .border(Color.black)
                            .frame(width: 250, height: 250)
                        Text("Glider Gun").foregroundColor(Color.black)
                    }
                }
            }
        }
    }
}
