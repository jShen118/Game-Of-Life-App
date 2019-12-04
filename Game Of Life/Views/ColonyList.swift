import SwiftUI

struct ColonyList: View {
    @Binding var colonyData: [Colony]
    @Binding var currentID: Int
    @State var isAdding = false
    
    func colonyIndex(_ colony: Colony)-> Int {
        return colony.id
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(colonyData) { colony in
                    Text("\(colony.name)")
                        .onTapGesture {self.currentID = colony.id}
                }
            }
            .navigationBarTitle(Text("Colonies"))
            .navigationBarItems(trailing:
                HStack {
                    Button(action: { self.isAdding.toggle() }) {
                        Text("+")
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .padding()
                    }
                    .sheet(isPresented: $isAdding) {
                        Templates(colonyData: self.$colonyData, isAdding: self.$isAdding)
                    }
                })
        }
    }
}
