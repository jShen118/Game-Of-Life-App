import SwiftUI

struct ColonyList: View {
    @Binding var colonyData: [Colony]
    @Binding var currentID: Int
    @State var isAdding = false
    
    func colonyIndex(_ colony: Colony)-> Int {
        return colony.id
    }
    
    var body: some View {
        List {
            ForEach(self.colonyData) { colony in
                ColonyRow(colony: colony)
                    .onTapGesture {self.currentID = colony.id}
            }.onDelete(perform: self.delete)
        }
        .navigationBarTitle(Text("Colonies"))
        .navigationBarItems(trailing:
            HStack {
                Button(action: { self.isAdding.toggle() }) {
                    Text("+")
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .padding()
                }.frame(height: 100)
                .sheet(isPresented: self.$isAdding) {
                    Templates(colonyData: self.$colonyData, isAdding: self.$isAdding, currentID: self.$currentID)
                }
            }
        )
    }
    
    func delete(at offsets: IndexSet) {
        colonyData.remove(atOffsets: offsets)
    }
}
