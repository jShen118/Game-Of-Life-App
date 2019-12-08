import SwiftUI

struct ColonyRow: View {
    var colony: Colony
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
<<<<<<< HEAD
                Text("  \(self.colony.name)")
=======
                Spacer()
                Text("\(self.colony.name)                                                            ")
>>>>>>> 74b8ced3f189c7df15331dd6861939b0b786efdb
                Spacer()
            }
        }
    }
}
