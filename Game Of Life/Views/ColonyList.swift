import SwiftUI

struct ColonyList: View {
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
                    .onTapGesture {self.currentID = self.colonyIndex(colony)}
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
                    Templates(colonyData: self.$colonyData, isAdding: self.$isAdding)
                }
            }
        )
    }
    
    func delete(at offsets: IndexSet) {
        if currentID == colonyData.count - 1 && colonyData.count > 1 {currentID -= 1}
        colonyData.remove(atOffsets: offsets)
    }
}
