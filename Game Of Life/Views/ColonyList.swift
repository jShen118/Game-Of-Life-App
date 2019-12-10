import SwiftUI

struct ColonyList: View {
    @State private var showingAlert = false
    @Binding var colonyData: [Colony]
    @Binding var currentID: Int
    @State var isAdding = false
    
    func colonyIndex(_ colony: Colony)-> Int {
        for i in 0..<colonyData.count {
            if colonyData[i].name == colony.name {return i}
        }
        return 0
    }
    
    var body: some View {
        List {
            ForEach(self.colonyData) { colony in
                ColonyRow(colony: colony)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {self.currentID = self.colonyIndex(colony)}
                    .background((self.currentID == self.colonyIndex(colony)) ? Color.gray.opacity(0.5) : Color.white)
            }.onDelete(perform: self.delete)
        }
        .navigationBarTitle(Text("Colonies"))
        .navigationBarItems(trailing:
            HStack {
                Button(action: {
                    if self.colonyData[self.currentID].name == "New Colony" {self.showingAlert = true}
                    else {self.isAdding.toggle()}
                }) {
                    Text("+")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .padding()
                }.frame(height: 100)
                 .alert(isPresented: $showingAlert) {
                     Alert(title: Text("Error"), message: Text("Please give your colony a name before adding a new one."), dismissButton: .default(Text("Okay")))
                 }
                .sheet(isPresented: self.$isAdding) {
                    Templates(colonyData: self.$colonyData, isAdding: self.$isAdding, currentID: self.$currentID)
                }
            }
        )
    }
    
    func delete(at offsets: IndexSet) {
        if colonyData.count > 1 {
            if currentID == colonyData.count - 1 && colonyData.count > 1 {currentID -= 1}
            colonyData.remove(atOffsets: offsets)
        } else {
            colonyData.append(Colony("New Colony"))
            colonyData.remove(atOffsets: offsets)
        }
    }
}
