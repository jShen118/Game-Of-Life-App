import SwiftUI
import Foundation
import Combine

struct ColonyView: View {
    @Binding var colony: Colony
    @State var evolveTime = 1.0
    var evolutionTimer: Publishers.Autoconnect<Timer.TimerPublisher> {
        return Timer.publish(every: TimeInterval(evolveTime), on: .main, in: .common).autoconnect()
    }
    @State var isEvolving = false
    @State var wrap = false
    
    var body: some View {
        VStack {
            if colony.name == "Enter New Colony Name" {
                TextField("", text: self.$colony.name)
                    .foregroundColor(.gray)
            } else {
                TextField("", text: self.$colony.name)
            }
            VStack(spacing: 0) {
                ForEach(0..<60) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<60) { col in
                            if self.colony.isCellAlive(Coordinate(row, col)) {
                                Rectangle().fill(Color.green)
                                    .frame(width: 10, height: 10)
                                    .padding(1)
                                    .onTapGesture {self.colony.toggleLife(Coordinate(row, col))}
                            } else {
                                Rectangle().fill(Color.red)
                                    .frame(width: 10, height: 10)
                                    .padding(1)
                                    .onTapGesture {self.colony.toggleLife(Coordinate(row, col))}
                            }
                        }
                    }
                }
            }.drawingGroup()
            .onReceive(evolutionTimer) {_ in
                if self.isEvolving {
                    if self.wrap {self.colony.evolveWrap()}
                    else {self.colony.evolve()}
                }
            }
            HStack {
                Button(action: {self.isEvolving.toggle()}) {
                    Text("Evolve")
                }
                Slider(value: $evolveTime, in: 0.1...2, step: 0.05)
                Toggle(isOn: $wrap) {EmptyView()}
            }
        }
    }
}
