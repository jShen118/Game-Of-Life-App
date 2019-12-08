import SwiftUI

struct ColonyRow: View {
    var colony: Colony
    
    var body: some View {
        Text("\(self.colony.name)                                                            ")
    }
}
