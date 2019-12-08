import SwiftUI

struct ColonyRow: View {
    var colony: Colony
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text("  \(self.colony.name)")
                Spacer()
            }
        }
    }
}
